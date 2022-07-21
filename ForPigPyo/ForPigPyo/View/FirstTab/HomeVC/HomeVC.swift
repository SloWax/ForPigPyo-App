//
//  HomeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MobileCoreServices
import AuthenticationServices

class HomeVC: UIViewController {
    
    static let forkey: String = "HomeVC"
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        
        return indicator
    }()
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        return imagePicker
    }()
    private lazy var homeView: HomeView = {
        let home = HomeView()
        
        home.partCollection.delegate = self
        home.partCollection.dataSource = self
        home.partCollection.register(HomeCustomItem.self, forCellWithReuseIdentifier: HomeCustomItem.identifier)
        return home
    }()
    private var loginAppearCount: Int = 0
    
    let model: HomeVCModel = HomeVCModel(
        menu: [
            HomeVCModel.Menu(
                title: "급여 계산기",
                subTitle: "이번 달엔 얼마나 받을까?",
                myPageMenu: [
                    HomeVCModel.Menu.PageMenu(
                        image: "hourly",
                        title: "나의 시급 설정"
                    ),
                    HomeVCModel.Menu.PageMenu(
                        image: "worktime",
                        title: "근무 시간 설정"
                    ),
                    HomeVCModel.Menu.PageMenu(
                        image: "tax",
                        title: "기본 세금 설정"
                    )
                ]
            ),
            HomeVCModel.Menu(
                title: "목표를 위한 저축",
                subTitle: "목표까지는 얼마나 남았을까요?",
                myPageMenu: []
            ),
            HomeVCModel.Menu(
                title: "새로운 기능",
                subTitle: "원하는 기능을 보내주세요!",
                myPageMenu: []
            )
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setHomeView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLogin(disMiss: loginAppearCount)
    }
    
    private func setView() {
        navigationItem.title = "모두의 앱"
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setHomeView() {
        
        view.addSubview(homeView)
        homeView.addSubview(indicator)
        
        homeView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicator.snp.makeConstraints {
            
            $0.center.equalToSuperview()
        }
    }
    private func checkLogin(disMiss: Int) {
        guard disMiss == 0 else { return }
        loginAppearCount += 1
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let userID = UserDefaults.standard.string(forKey: LoginVC.userID) ?? ""
        
        appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, _) in
            switch credentialState {
            case .authorized:
                
                print("authorized")
            case .revoked, .notFound :
                
                UserDefaults.standard.set(nil, forKey: LoginVC.userID)
                
                DispatchQueue.main.async {
                    let loginVC = LoginVC()
                    loginVC.modalPresentationStyle = .formSheet
                    self.present(loginVC, animated: true)
                }
                print("revoked or notFound")
            case .transferred:
                
                print("trans")
            @unknown default:
                
                print("default")
            }
        }
    }
    
    func saveBackImage(image: UIImage?) {
        
        if let pngData = image?.pngData() {
            
            model.saveBackImage(data: pngData, forkey: HomeVC.forkey)
        } else {
            
            model.saveBackImage(data: nil, forkey: HomeVC.forkey)
        }
    }
    
    // rightBarButton Action
    @objc private func setBackground(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "배경화면 설정", message: nil, preferredStyle: .actionSheet)
        
        let pickerButton = UIAlertAction(title: "갤러리에서 선택", style: .default) { _ in
            
            self.indicator.startAnimating()
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = [kUTTypeImage] as [String]
            self.present(self.imagePicker, animated: true) {
                
                self.indicator.stopAnimating()
            }
        }
        let resetButton = UIAlertAction(title: "리셋", style: .default) { _ in
            
            self.saveBackImage(image: nil)
            self.backImageView.image = nil
        }
        let cancleButton = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancleButton)
        alert.addAction(pickerButton)
        alert.addAction(resetButton)
        
        present(alert, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // 줄 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Design.largestPadding
    }
    // 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Design.padding
    }
    // 테두리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return Design.edge
    }
    // 아이템 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (Design.edge.left + Design.edge.right) - (Design.padding * (Design.partLineCount - 1))) / Design.partLineCount
        
        return CGSize(width: size, height: size / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCustomItem.identifier, for: indexPath) as? HomeCustomItem else { fatalError() }
        item.setValue(title: model.menu[indexPath.row].title,
                      subTitle: model.menu[indexPath.row].subTitle)
        
        return item
    }
}

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? HomeCustomItem else { fatalError() }
        
        switch indexPath.item {
        case 0:
            let partVC = PartTimeVC()
            
            partVC.partTimeView.titleLabel.attributedText = item.titleLabel.text?.underLine
            navigationController?.pushViewController(partVC, animated: true)
        case 1:
            let savingVC = SavingVC()
            
            savingVC.savingView.titleLabel.attributedText = item.titleLabel.text?.underLine
            navigationController?.pushViewController(savingVC, animated: true)
        case 2:
            let emailVC = EmailVC()
            
            emailVC.emailView.titleLabel.attributedText = item.titleLabel.text?.underLine
            navigationController?.pushViewController(emailVC, animated: true)
        default:
            fatalError()
        }
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.presentingViewController?.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        saveBackImage(image: image)
        backImageView.image = image
        
        picker.presentingViewController?.dismiss(animated: true)
    }
}

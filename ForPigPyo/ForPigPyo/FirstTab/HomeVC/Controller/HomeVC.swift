//
//  HomeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MobileCoreServices

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
    
    let model: HomeVCModel = HomeVCModel(menu: [HomeVCModel.Menu(title: "급여 계산기",
                                                                 subTitle: "이번 달엔 얼마나 받을까?",
                                                                 myPageMenu: ["나의 시급 설정", "기본 세금 설정"]),
                                                HomeVCModel.Menu(title: "목표를 위한 저축",
                                                                 subTitle: "목표까지는 얼마나 남았을까요?",
                                                                 myPageMenu: []),
                                                HomeVCModel.Menu(title: "새로운 기능",
                                                                 subTitle: "원하는 기능을 보내주세요!",
                                                                 myPageMenu: [])])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setHomeView()
    }
    
    private func setView() {
        
        navigationItem.title = "모두의 앱"
        
//        let rightButton = UIBarButtonItem(image: UIImage(systemName: "photo.fill"), style: .plain, target: self, action: #selector(setBackground(_:)))
//        navigationItem.rightBarButtonItem = rightButton
        
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
    
    func saveBackImage(image: UIImage?) {
        
        if let pngData = image?.pngData() {
            
            model.saveBackImage(data: pngData, forkey: HomeVC.forkey)
        } else {
            
            model.saveBackImage(data: nil, forkey: HomeVC.forkey)
        }
    }
    func loadBackImage(forkey: String) -> UIImage? {
        
        if let image = model.loadBackImage(forkey: forkey) {
            
            return UIImage(data: image)
        } else {
            
            return nil
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

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
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.purple
        
        return imageView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        return imagePicker
    }()
    
    lazy var homeView: HomeView = {
        let home = HomeView()
        
        home.partCollection.delegate = self
        home.partCollection.dataSource = self
        home.partCollection.register(PartCustomItem.self, forCellWithReuseIdentifier: PartCustomItem.identifier)
        return home
    }()
    
    let model = HomeVCModel()
    
    static let forkey: String = "HomeVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setHomeView()
    }
    
    private func setView() {
        
        navigationItem.title = "List"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Design.LargeTextSize ?? UIFont()]
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "photo.fill"), style: .plain, target: self, action: #selector(setBackground(_:)))
        navigationItem.rightBarButtonItem = rightButton
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setHomeView() {
        
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
    @objc private func setBackground(_ sender: UIButton) {
        let alert = UIAlertController(title: "배경화면 설정", message: nil, preferredStyle: .actionSheet)
        
        let pickerButton = UIAlertAction(title: "갤러리에서 선택", style: .default) { _ in
            
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = [kUTTypeImage] as [String]
            self.present(self.imagePicker, animated: true)
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

//
//  HomeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//

import UIKit

class HomeVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        
        return imageView
    }()
    
    lazy var homeView: HomeView = {
        let home = HomeView()
        
        home.partCollection.delegate = self
        home.partCollection.dataSource = self
        home.partCollection.register(PartCustomItem.self, forCellWithReuseIdentifier: PartCustomItem.identifier)
        return home
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageView()
        setHomeView()
    }
    private func setImageView() {
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setHomeView() {
        
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.snp_margins)
        }
    }
}

//
//  MainTabVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit


class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = makeNaviController(
            tabBarImage: "wallet",
            rootViewController: HomeVC()
        )
        
        homeVC.title = "모두의 앱"
        
        let myPageVC = makeNaviController(
            tabBarImage: "gingerbread",
            rootViewController: MyPageVC()
        )
        
        myPageVC.title = "마이페이지"
        
        viewControllers = [homeVC, myPageVC]
        
        tabBar.tintColor = .setCustomColor(.textBasic)
    }
    
    func makeNaviController(tabBarImage: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let naviController = UINavigationController(rootViewController: rootViewController)
        
        naviController.tabBarItem.image = UIImage(named: tabBarImage)
        
        naviController.navigationBar.tintColor = .setCustomColor(.textBasic)
        naviController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.setCustomFont(font: .bold, size: 20)
        ]
        
        naviController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        naviController.navigationBar.shadowImage = UIImage()
        naviController.navigationBar.isTranslucent = true
        
        return naviController
    }
}

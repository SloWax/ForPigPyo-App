//
//  MainTabVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// TabBarController 생성 시 NavigationController와 함께 생성

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = makeNaviController(tabBarImage: "house", rootViewController: HomeVC())
        homeVC.title = "홈"
        
        
        let myPageVC = makeNaviController(tabBarImage: "person", rootViewController: MyPageVC())
        myPageVC.title = "마이페이지"
        
        viewControllers = [homeVC, myPageVC]
        
        tabBar.tintColor = Design.purple
    }
    
    func makeNaviController(tabBarImage: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let naviController = UINavigationController(rootViewController: rootViewController)
        
        naviController.tabBarItem.image = UIImage(systemName: tabBarImage)
        naviController.navigationBar.tintColor = Design.purple
        
        return naviController
    }
}

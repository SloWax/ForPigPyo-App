//
//  MainTabVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = makeNaviController(tabBarImage: "house", rootViewController: HomeVC())
        homeVC.title = "홈"
        
        
        let myPageVC = makeNaviController(tabBarImage: "person", rootViewController: MyPageVC())
        myPageVC.title = "마이페이지"
        
        viewControllers = [homeVC, myPageVC]
        
        tabBar.tintColor = .systemPurple
    }
    
    func makeNaviController(tabBarImage: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        
        navController.tabBarItem.image = UIImage(systemName: tabBarImage)
        navController.navigationBar.tintColor = .systemPurple
        
        return navController
    }
}

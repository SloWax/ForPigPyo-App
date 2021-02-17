//
//  AppDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 광고 초기화
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // HomeVC에서 저장된 배경이미지가 있을 경우 HomeVC와 MyPageVC에 설정
        let mainTabVC = MainTabVC()
        if let homeVC = mainTabVC.viewControllers?[0].children[0] as? HomeVC {
            
            homeVC.backImageView.image = homeVC.loadBackImage(forkey: HomeVC.forkey)
            if let myPageVC = mainTabVC.viewControllers?[(mainTabVC.viewControllers?.count ?? 2) - 1].children[0] as? MyPageVC {
                
                myPageVC.backImageView.image = homeVC.loadBackImage(forkey: HomeVC.forkey)
                myPageVC.menuData = homeVC.model
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = mainTabVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

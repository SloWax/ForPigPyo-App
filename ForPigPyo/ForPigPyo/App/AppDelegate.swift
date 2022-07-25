//
//  AppDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // 광고 초기화
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // HomeVC 리스트별 마이페이지 메뉴 불러오기
        let mainTabVC = MainTabVC()
        
//        if let homeVC = mainTabVC.viewControllers?[0].children[0] as? HomeVC {
//            
//            if let myPageVC = mainTabVC.viewControllers?[(mainTabVC.viewControllers?.count ?? 2) - 1].children[0] as? MyPageVC {
//                
//                myPageVC.menuData = homeVC.model
//            }
//        }
        
        // firebase에 저장된 정보가 있을 경우 불러오기
        let loginVCModel = LoginVCModel()
        loginVCModel.loadFromDB()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = mainTabVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

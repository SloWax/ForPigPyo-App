//
//  AppDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import CoreData
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

    // 다음 업데이트 시 UserDefaults가 아닌 Core Data 구현 예정
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ForPigPyo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


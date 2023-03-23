//
//  MainTabVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/03.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import RxSwift


class MainTC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        let nomalTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.setCustomFont(font: .regular, size: 12),
            .foregroundColor: UIColor.setCustomColor(.gray4)
        ]
        let selectedTitle: [NSAttributedString.Key: Any] = [
            .font: UIFont.setCustomFont(font: .medium, size: 12),
            .foregroundColor: UIColor.setCustomColor(.textBasic)
        ]
        
        tabBarItemAppearance.normal.titleTextAttributes = nomalTitle
        tabBarItemAppearance.selected.titleTextAttributes = selectedTitle
        tabBarItemAppearance.selected.iconColor = .setCustomColor(.textBasic)

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = .setCustomColor(.white)
        tabBarAppearance.shadowImage = UIColor.setCustomColor(.gray4).toImage(height: 0.5)
        
        tabBar.standardAppearance = tabBarAppearance
        
        let viewController = [
//            TabBarVC(vc: HomeVC(), itme: UITabBarItem(
            TabBarVC(vc: newPartTimeVC(), itme: UITabBarItem(
                title: "모두의 앱",
                image: UIImage(named: "wallet"),
                tag: 0
            )),
            TabBarVC(vc: MyPageVC(), itme: UITabBarItem(
                title: "마이페이지",
                image: UIImage(named: "gingerbread"),
                tag: 1
            ))
        ]

        viewControllers = viewController.map { $0.navi }
    }
}

fileprivate class TabBarVC {
    
    let vc: UIViewController
    let item: UITabBarItem
    
    init(vc: UIViewController, itme: UITabBarItem) {
        self.vc = vc
        self.item = itme
    }
    
    var navi: BaseNC {
        let navi = BaseNC(rootViewController: vc)
        navi.tabBarItem = item

        return navi
    }
}

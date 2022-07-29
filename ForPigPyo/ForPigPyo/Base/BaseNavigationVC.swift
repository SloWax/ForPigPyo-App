//
//  BaseNavigationVC.swift
//  Carsuri
//
//  Created by 홍서진 on 2021/11/24.
//

import UIKit

enum NavigationType {
    case basic(title: String?)
    case main
    case logo
    case logoOnly
    case fullScreen
}

class BaseNavigationVC: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let _ = self.topViewController as? MainTabVC {
            return .darkContent
        } else {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                // Fallback on earlier versions
                return .default
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
        let image = UIImage(named: "btn_back_28")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)

        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance;
        navigationBar.clipsToBounds = true
        
        // ios 15...
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        //https://developer.apple.com/documentation/uikit/uinavigationcontroller/customizing_your_app_s_navigation_bar
    }
}

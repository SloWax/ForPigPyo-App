//
//  Extension+UIViewController.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/29.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit

extension UIViewController {
    // 기본 present
    func presentVC(_ vc: UIViewController, _ animated: Bool = true, modal: UIModalPresentationStyle = .fullScreen, title: String = "", completion: (() -> Void)? = nil) {
        switch vc {
        case is BaseModalVC:
            vc.modalPresentationStyle = .overFullScreen
        default:
            vc.modalPresentationStyle = modal
        }
        
        if let navi = vc as? BaseNavigationVC {
            navi.rootViewController?.title = title
        }
        
        self.present(vc, animated: animated) {
            completion?()
        }
    }
}

//
//  Extension+UIView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/21.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func addShadow(offset: ShadowOffset, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 5) {
        switch offset {
        case .top:
            let size = CGSize(width: 0, height: -5)
            addShadow(offset: size, color: color, opacity: opacity, radius: radius)
        case .left:
            let size = CGSize(width: -10, height: 0)
            addShadow(offset: size, color: color, opacity: opacity, radius: radius)
        case .right:
            let size = CGSize(width: 10, height: 0)
            addShadow(offset: size, color: color, opacity: opacity, radius: radius)
        case .bottom:
            let size = CGSize(width: 0, height: 10)
            addShadow(offset: size, color: color, opacity: opacity, radius: radius)
        }
    }
    
    private func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    enum ShadowOffset {
        case top
        case left
        case right
        case bottom
    }
}

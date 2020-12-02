//
//  CollectionInset.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import Foundation

struct Design {
    // MARK: backgroundColor
    static let purple: UIColor = UIColor(displayP3Red: 203/255, green: 166/255, blue: 249/255, alpha: 1)
    
    // MARK: textColor
    static let textBasic: UIColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let textRedSun: UIColor = UIColor(displayP3Red: 236/255, green: 120/255, blue: 115/255, alpha: 1)
    static let textBlueSat: UIColor = UIColor(displayP3Red: 102/255, green: 112/255, blue: 238/255, alpha: 1)
    
    // MARK: padding
    static let padding: CGFloat = 30
    static let edge = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    static let tableEdge = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    static let partLineCount: CGFloat = 1
    
    static let smallPadding: CGFloat = 5
    static let nomalPadding: CGFloat = 10
    static let LargePadding: CGFloat = 15
    
    // MARK: border
    static let qurterBorderWidth: CGFloat = 0.25
    static let halfBorderWidth: CGFloat = 0.5
    static let qurterCornerRadius: CGFloat = 7.5
    static let cornerRadius: CGFloat = 10
    
    // MARK: font
    static let smallTextSize = UIFont(name: "BMHANNAAirOTF", size: 16)
    static let nomalTextSize = UIFont(name: "BMHANNAAirOTF", size: 19)
    static let LargeTextSize = UIFont(name: "BMHANNAAirOTF", size: 22)
    
    static let boldSmallTextSize = UIFont(name: "BMHANNA11yrsoldOTF", size: 14)
    static let boldNomalTextSize = UIFont(name: "BMHANNA11yrsoldOTF", size: 20)
    static let boldLargeTextSize = UIFont(name: "BMHANNA11yrsoldOTF", size: 26)
    static let boldHeaderTextSize = UIFont(name: "BMHANNA11yrsoldOTF", size: 32)
    
}

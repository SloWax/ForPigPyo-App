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
    static let lightGray: UIColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
    static let gray: UIColor = UIColor(displayP3Red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
    static let yellow: UIColor = UIColor(displayP3Red: 255/255, green: 209/255, blue: 0/255, alpha: 1)
    
    // MARK: textColor
    static let textBasic: UIColor = UIColor(displayP3Red: 57/255, green: 57/255, blue: 57/255, alpha: 1)
    static let textRedSun: UIColor = UIColor(displayP3Red: 237/255, green: 99/255, blue: 99/255, alpha: 1)
    static let textBlueSat: UIColor = UIColor(displayP3Red: 111/255, green: 116/255, blue: 234/255, alpha: 1)
    
    // MARK: padding
    static let padding: CGFloat = 30
    static let edge = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    static let tableEdge = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    static let partLineCount: CGFloat = 1
    
    static let smallPadding: CGFloat = 5
    static let nomalPadding: CGFloat = 10
    static let largePadding: CGFloat = 15
    static let largestPadding: CGFloat = 20
    
    // MARK: border
    static let qurterBorderWidth: CGFloat = 0.25
    static let halfBorderWidth: CGFloat = 0.5
    static let oneFifthCornerRadius: CGFloat = 5
    static let twentyCornerRadius: CGFloat = 20
    static let cornerRadius: CGFloat = 25
    
    // MARK: font
    static let smallTextSize = UIFont(name: "NotoSansCJKkr-Black", size: 16)
    static let nomalTextSize = UIFont(name: "NotoSansCJKkr-Black", size: 19)
    static let largeTextSize = UIFont(name: "NotoSansCJKkr-Black", size: 22)
    static let headerTextSize = UIFont(name: "NotoSansCJKkr-Black", size: 26)
    
    static let boldSmallTextSize = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
    static let boldNomalTextSize = UIFont(name: "NotoSansCJKkr-Bold", size: 20)
    static let boldLargeTextSize = UIFont(name: "NotoSansCJKkr-Bold", size: 26)
    static let boldHeaderTextSize = UIFont(name: "NotoSansCJKkr-Bold", size: 32)
    
}

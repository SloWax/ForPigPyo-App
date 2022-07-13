//
//  Extension+UIFont.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/13.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit

extension UIFont {
    // 폰트 설정
    class func setCustomFont(font: Name, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size)!
    }
    
    // 폰트 굵기
    enum Name: String {
        case black   = "NotoSansCJKkr-Black"
        case bold    = "NotoSansCJKkr-Bold"
        case medium  = "NotoSansCJKkr-Medium"
    }
}

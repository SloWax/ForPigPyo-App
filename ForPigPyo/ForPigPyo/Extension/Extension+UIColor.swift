//
//  Extension+UIColor.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/13.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(rgb: UInt) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class func setCustomColor(_ code: ColorCode, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(named: code.rawValue) else { fatalError("Not found color: \(code.rawValue)") }
        return color.withAlphaComponent(alpha)
    }
}

enum ColorCode: String {
    
    // UI
    case purple    = "#CBA6F9"
    case lightGray = "#EBEBEB"
    case gray      = "#DDDDDD"
    case yellow    = "#FFD100"

    // text
    case textBasic = "#393939"
    case textRed   = "#ED6363"
    case textBlue  = "#6F74EA"
}

//
//  Underline.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/24.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addBottomBorder(borderWidth: CGFloat) {
        
        let border = UIView()
        border.backgroundColor = Design.yellow
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: borderWidth)
        
        addSubview(border)
    }
}

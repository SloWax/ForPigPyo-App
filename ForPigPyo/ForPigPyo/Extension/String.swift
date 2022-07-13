//
//  String.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/20.
//  Copyright © 2021 SloWax. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var convertTime: [String] {
        var hour: String = ""
        var min: String = ""
        var check: Bool = false

        forEach {
            if "0"..."9" ~= $0, check == false {
                hour += String($0)
            } else if "0"..."9" ~= $0, check == true {
                min += String($0)
            } else {
                check = true
            }
        }
        
        return [hour, min]
    }
    
    var underLine: NSAttributedString {
        
        let lineStyle = NSUnderlineStyle.init(rawValue: 20).rawValue
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: lineStyle,
            NSAttributedString.Key.foregroundColor: Design.textBasic,
            NSAttributedString.Key.underlineColor: Design.yellow]

        let attributedString = NSAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
}

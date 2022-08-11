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
    
    var won: String {
        return "\(self) 원"
    }
    
    var underLine: NSAttributedString {
        let lineStyle = NSUnderlineStyle.init(rawValue: 20).rawValue
        
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: lineStyle,
            .foregroundColor: UIColor.setCustomColor(.textBasic),
            .underlineColor: UIColor.setCustomColor(.yellow)
        ]

        let attributedString = NSAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func limitTextCount(_ maxLength: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: maxLength)
        let newString = self[self.startIndex ..< index]
        
        return String(newString)
    }
    
    func isValidation(_ pattern: String) -> Bool { // Validation
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    
    func removeDecimalDigits() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

//
//  Extension+Int.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/11.
//  Copyright © 2022 SloWax. All rights reserved.
//

import Foundation

extension Int {
    var comma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: self as NSNumber) ?? ""
    }
    
    var splitTime: WorkTime {
        let hour = self / 60
        let min = self % 60
        
        return (hour, min)
    }
    
    func sumTax(_ tax: TaxCase) -> Int {
        switch tax {
        case .free        : return self
        case .withHolding : return Int(Double(self) * 0.967)
        case .insurance   : return Int(Double(self) * 0.906)
        }
    }
}

//
//  Case.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/12.
//  Copyright © 2022 SloWax. All rights reserved.
//

import Foundation

typealias WorkTime = (hour: Int, min: Int)
typealias OnWorkTime = (WorkTime) -> Void
typealias CallBack = () -> Void

// 세금 유형
enum TaxCase: String, CaseIterable {
    case free = "미공제"
    case withHolding = "3.3%"
    case insurance = "4대보험"
}

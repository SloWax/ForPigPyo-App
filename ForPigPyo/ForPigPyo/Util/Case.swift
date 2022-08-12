//
//  Case.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/12.
//  Copyright © 2022 SloWax. All rights reserved.
//

import Foundation


// 세금 유형
enum TaxCase: String, CaseIterable {
    case free = "미공제"
    case withholding = "3.3%"
    case insurance = "4대보험"
}

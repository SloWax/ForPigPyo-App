//
//  MyPageVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct MyPageVCModel: Codable {
    
    struct HourlyWage: Codable {
        
        let myHourlyWage: String
    }
    struct Tax: Codable {
        
        let myTax: Int
    }
    
    static let myPageVCHourly: String = "MyPageVCHourly"
    static let MyPageVCTax: String = "MyPageVCTax"
    static let taxCategory: [String] = ["미공제", "3.3%", "4대보험"]
}

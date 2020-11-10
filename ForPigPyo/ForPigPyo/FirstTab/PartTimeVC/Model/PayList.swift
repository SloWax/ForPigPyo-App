//
//  PayList.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PayList: Codable {
    
    var month: [Month]
    
    struct Month: Codable {
        
        var data: [Data]
        
        struct Data: Codable {
            
            let date: String
            
            let workingTime: Int
            let overWorkingTime: Int
            let nightWorkTime: Int
            let overNightWorkTime: Int
            
            let hourlyWage: Int
            let totalPay: Int
        }
    }
}

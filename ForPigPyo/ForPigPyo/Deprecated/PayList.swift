//
//  PayList.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PayList: Codable {
    
    var years: [Year]
    
    struct Year: Codable {
        
        let year: Int
        var months: [Month]
        
        struct Month: Codable {
            
            let month: Int
            var data: [Data]
            
            struct Data: Codable {
                
                let date: Int
                let weekDay: String
                
                let workingTime: Int
                let workingTimeMin: Int
                
                let overTime: Int
                let overTimeMin: Int
                
                let nightTime: Int
                let nightTimeMin: Int
                
                let overNightTime: Int
                let overNightTimeMin: Int
                
                let hourlyWage: Int
                let totalTime: String
                let totalPay: Int
            }
        }
    }
}

//
//  PayList.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PayList: Codable {
    
    let month: [Month]
    
    struct Month: Codable {
        
        let data: [Data]
        
        struct Data: Codable {
            
            let date: String
            
            let workingTime: Int
            let overWorkingTime: Int
            
            let hourlyWage: Int
            let totalPay: Int
        }
    }
}

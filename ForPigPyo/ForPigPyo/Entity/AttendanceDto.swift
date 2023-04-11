//
//  AttendanceDto.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/10.
//  Copyright © 2023 SloWax. All rights reserved.
//


import Foundation

struct AttendanceDto: Codable {
    let id: Date
    
    let date: Date
    let wage: Int
    
    let workTime: Int
    let overTime: Int
    let nightTime: Int
    let overNightTime: Int
    let total: Int
    
    let dayPay: Int
}

//
//  AttendanceModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/06.
//  Copyright © 2023 SloWax. All rights reserved.
//

import Foundation

struct AttendanceModel {
    let date: Date
    let wage: Int
    
    let workTime: WorkTime
    let overTime: WorkTime
    let nightTime: WorkTime
    let overNightTime: WorkTime
    let total: WorkTime
    
    let dayPay: Int
}

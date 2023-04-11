//
//  AttendanceModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/06.
//  Copyright © 2023 SloWax. All rights reserved.
//

import Foundation

struct TimeCardModel {
    
    enum TimeType {
        case work
        case over
        case night
        case overNight
        case total
    }
    
    struct Attendance {
        let id: Date
        
        let date: Date
        let wage: Int
        
        let workTime: WorkTime
        let overTime: WorkTime
        let nightTime: WorkTime
        let overNightTime: WorkTime
        let total: WorkTime
        
        let dayPay: Int
        
        func combineTime(_ type: TimeType) -> Int {
            let time: WorkTime
            
            switch type {
            case .work      : time = self.workTime
            case .over      : time = self.overTime
            case .night     : time = self.nightTime
            case .overNight : time = self.overNightTime
            case .total     : time = self.total
            }
            
            let result = (time.hour * 60) + time.min
            return result
        }
    }
}

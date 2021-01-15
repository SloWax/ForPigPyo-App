//
//  TimeDataVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/20.
//  Copyright © 2021 SloWax. All rights reserved.
//

import Foundation

struct TimeDataVCModel {
    
    // MARK: 요일 확인
    func getWeekDay(year:Int, month:Int, day:Int) -> String {
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents: DateComponents = {
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            
            return components
        }()
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            formatter.locale = Locale(identifier: "ko-KR")
            
            return formatter
        }()
        
        let fromDate = calendar.date(from: dateComponents)
        
        return dateFormatter.string(from: fromDate ?? Date())
    }
    
    // MARK: 총 근무시간 계산
    func totalWorkCalcu(work: Int, workMin: Int, over: Int, overMin: Int, night: Int, nightMin: Int, overNight: Int, overNightMin: Int) -> [Int] {
        
        var hour: Int = hourCalcu(work: work, over: over, night: night, overNight: overNight)
        var min: Int = minCalcu(workMin: workMin, overMin: overMin, nightMin: nightMin, overNightMin: overNightMin)
        
        let convertHour: Int = min/60
        let remainderMin: Int = min%60
        
        hour = hour + convertHour
        min = remainderMin
        
        return [hour, min]
    }
    
    private func hourCalcu(work: Int, over: Int, night: Int, overNight: Int) -> Int {
        
        let result: Int = work + over + night + overNight
        
        return result
    }
    private func minCalcu(workMin: Int, overMin: Int, nightMin: Int, overNightMin: Int) -> Int {
        
        let result: Int = workMin + overMin + nightMin + overNightMin
        
        return result
    }
    
    // MARK: 일 급여 계산
    func totalPaySum(hourly: Double, working: Double, workingMin: Double, over: Double, overMin: Double, night: Double, nightMin: Double, overNight: Double, overNightMin: Double) -> Int {
        
        let workingAll: Double = convertTime(hour: working, min: workingMin)
        let overAll: Double = convertTime(hour: over, min: overMin)
        let nightAll: Double = convertTime(hour: night, min: nightMin)
        let overNightAll: Double = convertTime(hour: overNight, min: overNightMin)
        
        let pay: Double = calcuPay(time: workingAll, hourly: hourly, double: 1)
        let overPay: Double = calcuPay(time: overAll, hourly: hourly, double: 1.5)
        let nightPay: Double = calcuPay(time: nightAll, hourly: hourly, double: 1.5)
        let overNightPay: Double = calcuPay(time: overNightAll, hourly: hourly, double: 2)
        
        let totalPay: Double = pay + overPay + nightPay + overNightPay
        
        return Int(totalPay)
    }
    
    private func convertTime(hour: Double, min: Double) -> Double {
        
        return hour + (min / 60)
    }
    private func calcuPay(time: Double, hourly: Double, double: Double) -> Double {
        
        return time * hourly * double
    }
    
    // MARK: data 추가 및 수정
    func editData(division: String, data: inout PayList?, yearIndex: Int, monthIndex: Int, saveIndex: Int, value: PayList.Year.Month.Data) -> PayList? {
        
        switch division {
        case "근무 추가하기":
            data?.years[yearIndex].months[monthIndex].data.insert(value, at: saveIndex)
            
            return sortedDate(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
        case "근무 수정하기":
            data?.years[yearIndex].months[monthIndex].data[saveIndex] = value
            
            return sortedDate(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
        default:
            fatalError()
        }
    }
    
    // MARK: data sorted
    func sortedDate(data: inout PayList?, yearIndex: Int, monthIndex: Int) -> PayList? {
        
        let value = data?.years[yearIndex].months[monthIndex]
        data?.years[yearIndex].months[monthIndex].data = value?.data.sorted(by: {$0.date > $1.date}) ?? [PayList.Year.Month.Data]()
        
        return data
    }
}

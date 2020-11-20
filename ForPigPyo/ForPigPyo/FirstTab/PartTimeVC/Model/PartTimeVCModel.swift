//
//  PartTimeVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PartTimeVCModel {
    
    // MARK: tableView에 있는 일 급여 합산
    func setTotalPay(data: PayList?, yearIndex: Int, monthIndex: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let value = data?.years[yearIndex].months[monthIndex].data
        var result = 0
        
        guard value?.count != 0 else { return "0" }
        
        value?.forEach({
            
            result += $0.totalPay
        })
        
        return formatter.string(from: result as NSNumber) ?? ""
    }
    
    // MARK: dataTable 확인
    func appendYear(data: inout PayList?, year: Int, month: Int) -> PayList? {
        
        data?.years.append(PayList.Year(year: year,
                                       months: [PayList.Year.Month(month: month,
                                                                   data: [PayList.Year.Month.Data]())]))
        
        return data
    }
    func appendMonth(data: inout PayList?, yearIndex: Int, month: Int) -> PayList? {
        
        data?.years[yearIndex].months.append(PayList.Year.Month(month: month,
                                                           data: [PayList.Year.Month.Data]()))
        
        return data
    }
    
    // MARK: data 추가 및 수정
    func editData(division: String, data: inout PayList?, yearIndex: Int, monthIndex: Int, index: Int, value: PayList.Year.Month.Data) -> PayList? {
        
        switch division {
        case "추가하기":
            data?.years[yearIndex].months[monthIndex].data.insert(value, at: index)
            
            return sortedData(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
        case "수정하기":
            data?.years[yearIndex].months[monthIndex].data[index] = value
            
            return sortedData(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
        default:
            fatalError()
        }
    }
    
    // MARK: data 저장 및 로드
    func saveData(data: PayList) {
        
        if let encoded = try? JSONEncoder().encode(data) {
            
            UserDefaults.standard.set(encoded, forKey: PartTimeVC.forkey)
        }
    }
    func loadData() -> PayList? {
        if let savedList = UserDefaults.standard.object(forKey: PartTimeVC.forkey) as? Data {
            if let loadedList = try? JSONDecoder().decode(PayList.self, from: savedList) {
                
                return loadedList
            }
        }
        return nil
    }
    
    // MARK: data sorted
    func sortedData(data: inout PayList?, yearIndex: Int, monthIndex: Int) -> PayList? {
        
        let value = data?.years[yearIndex].months[monthIndex]
        data?.years[yearIndex].months[monthIndex].data = value?.data.sorted(by: {$0.date > $1.date}) ?? [PayList.Year.Month.Data]()
        
        return data
    }
    
    // MARK: 일 급여 계산
    func totalPaySum(total: Double, totalMin: Double, hourly: Double, over: Double, overMin: Double, night: Double, nightMin: Double, overNight: Double, overNightMin: Double) -> Int {
        
        let totalAll = convertTime(hour: total, min: totalMin)
        let overAll = convertTime(hour: over, min: overMin)
        let nightAll = convertTime(hour: night, min: nightMin)
        let overNightAll = convertTime(hour: overNight, min: overNightMin)
        
        let pay = (totalAll - overAll - nightAll - overNightAll) * hourly
        let overPay = calcuPay(time: overAll, hourly: hourly, double: 1.5)
        let nightPay = calcuPay(time: nightAll, hourly: hourly, double: 1.5)
        let overNightPay = calcuPay(time: overNightAll, hourly: hourly, double: 2)
        
        let totalPay = pay + overPay + nightPay + overNightPay
        
        return Int(totalPay)
    }
    private func convertTime(hour: Double, min: Double) -> Double {
        
        return hour + (min / 60)
    }
    private func calcuPay(time: Double, hourly: Double, double: Double) -> Double {
        
        return time * hourly * double
    }
}

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
    func setTotalPay(data: PayList?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let value = data?.year[0].month[0].data
        var result = 0
        
        guard value?.count != 0 else { return "0" }
        
        for index in 0 ... (value?.count ?? 0) - 1 {
            result += value?[index].totalPay ?? 0
        }
        
        return formatter.string(from: result as NSNumber) ?? ""
    }
    // MARK: data 추가 및 수정
    func editData(division: String, data: PayList? ,index: Int, value: PayList.Years.Month.Data) -> PayList? {
        
        var result = data
        
        switch division {
        case "추가하기":
            result?.year[0].month[0].data.insert(value, at: index)
            
            return sortedData(data: &result)
        case "수정하기":
            result?.year[0].month[0].data[index] = value
            
            return sortedData(data: &result)
        default:
            fatalError()
        }
    }
    // MARK: data sorted
    func sortedData(data: inout PayList?) -> PayList? {
        
        let value = data?.year[0].month[0]
        
        data?.year[0].month[0].data = value?.data.sorted(by: {$0.date > $1.date}) ?? [PayList.Years.Month.Data]()
        return data
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
    // MARK: 일 급여 계산 Model
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

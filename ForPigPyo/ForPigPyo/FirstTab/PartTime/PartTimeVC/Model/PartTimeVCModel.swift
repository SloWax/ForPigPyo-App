//
//  PartTimeVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PartTimeVCModel {
    
    // MARK: Happy New Year!
    func appendYear(data: inout PayList?, yearIndex: Int, year: Int, month: Int) -> PayList? {
        
        data?.years.append(PayList.Year(year: year,
                                       months: [PayList.Year.Month]()))
        (1 ... 12).forEach({ (month) in
            
            data?.years[yearIndex + 1].months.append(PayList.Year.Month(month: month, data: [PayList.Year.Month.Data]()))
        })
        
        return data
    }
    
    // MARK: history에 있는 일 급여 합산
    func setTotalPay(data: PayList?, yearIndex: Int, monthIndex: Int, deduction: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let value: [PayList.Year.Month.Data]? = data?.years[yearIndex].months[monthIndex].data
        var result: Int = 0
        
        guard value?.count != 0 else { return "0" }
        
        value?.forEach({
            
            result += $0.totalPay
        })
        
        switch deduction {
        case 0:
            
            break
        case 1:
            
            result = Int(Double(result) * 0.967)
        case 2:
            
            result = Int(Double(result) * 0.91656)
        default:
            fatalError()
        }
        
        return formatter.string(from: result as NSNumber) ?? ""
    }
    
    // MARK: dataTable 확인
    func checkDataTable(data: inout PayList?, yearIndex: Int, monthIndex: Int, yearInt: Int, monthInt: Int) -> PayList? {
        if let checkData = data?.years {
            var checkCount = 0
            
            for check in checkData {
                if check.year == yearInt {
                    checkCount += 1
                    
                    break
                } else {
                    
                    continue
                }
            }
            guard checkCount == 0 else { return data }
            data = appendYear(data: &data, yearIndex: yearIndex, year: yearInt, month: monthInt)
        }
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
}

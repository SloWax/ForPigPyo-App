//
//  SavingVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import Foundation

struct SavingVCModel {
    
    // MARK: 현재까지 모은 금액
    func untilSavingCalcu(list: SavingList?) -> Int {
        
        var result: Int = 0
        
        list?.data.forEach { result += $0.saving }
        
        return result
    }
    
    // MARK: D-Day
    func untilDayCalcu(list: SavingList?) -> String {
        
        let calendar = Calendar.current
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier:"ko_KR")
            formatter.dateFormat = "yyyy-MM-dd"
            
            return formatter
        }()
        
        var day: Int = 0
        
        if let list = list {
            let toDate = formatter.date(from: list.aimDate)
            let fromDate = calendar.startOfDay(for: Date())
            let dDay = calendar.startOfDay(for: toDate ?? Date())
            
            let components = calendar.dateComponents([.day], from: fromDate, to: dDay)
            
            day = components.day ?? 0
        }
        
        let checkSign = Double(day) * -1
        guard checkSign != 0 else { return "D-Day" }
        
        var result: String
        
        checkSign.sign == .minus ? (result = "D\(Int(checkSign))") : (result = "D+\(Int(checkSign))")
        
        return result
    }
    
    // MARK: D-Day
    func thisMonthSaveCalcu(list: SavingList?) -> Int {
        
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier:"ko_KR")
            formatter.dateFormat = "yyyy-MM"
            
            return formatter
        }()
        var result: Int = 0
        
        list?.data.forEach({
            
            guard formatter.string(from: Date()) == "\($0.year)-\($0.month)" else { return }
            
            result += $0.saving
        })
        
        return result
    }
    
    // MARK: data 저장 및 로드
    func saveData(data: SavingList) {

        if let encoded = try? JSONEncoder().encode(data) {

            UserDefaults.standard.set(encoded, forKey: SavingVC.forkey)
        }
    }
    func loadData() -> SavingList? {
        if let savedList = UserDefaults.standard.object(forKey: SavingVC.forkey) as? Data {
            if let loadedList = try? JSONDecoder().decode(SavingList.self, from: savedList) {
                
                return loadedList
            }
        }
        return nil
    }
    
    // MARK: data 추가 및 수정
    func editData(division: String, data: inout SavingList?, saveIndex: Int, value: SavingList.Data) -> SavingList? {
        
        switch division {
        case "저축 추가하기":
            
            data?.data.insert(value, at: saveIndex)
            
            return sortedDate(data: &data)
        case "저축 수정하기":
            data?.data[saveIndex] = value
            
            return sortedDate(data: &data)
        default:
            fatalError()
        }
    }
    
    // MARK: data sorted
    func sortedDate(data: inout SavingList?) -> SavingList? {
        
        if var value = data?.data {
            value = value.sorted(by: {$0.month > $1.month})
            data?.data = value.sorted(by: {$0.year > $1.year})
        }
        
        return data
    }
}

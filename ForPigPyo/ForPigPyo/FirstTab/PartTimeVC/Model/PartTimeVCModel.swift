//
//  PartTimeVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct PartTimeVCModel {
    
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
            
            print("미공제")
        case 1:
            
            result = Int(Double(result) * 0.967)
        case 2:
            
            result = Int(Double(result) * 0.91656)
        default:
            fatalError()
        }
        
        return formatter.string(from: result as NSNumber) ?? ""
    }
    
    // MARK: WeekDay 확인
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
    
    // MARK: dataTable 확인
    func checkDataTable(data: inout PayList?, yearIndex: Int, monthIndex: Int, yearInt: Int, monthInt: Int) -> PayList? {
        if let checkData = data?.years {
            if !checkData.contains(where: { $0.year == yearInt }) {
                
                data = appendYear(data: &data, year: yearInt, month: monthInt)
            } else if !checkData[yearIndex].months.contains(where: { $0.month == monthInt }) {
                
                data = appendMonth(data: &data, yearIndex: yearIndex, month: monthInt)
            }
        }
        return data
    }
    private func appendYear(data: inout PayList?, year: Int, month: Int) -> PayList? {
        
        data?.years.append(PayList.Year(year: year,
                                       months: [PayList.Year.Month(month: month,
                                                                   data: [PayList.Year.Month.Data]())]))
        
        return data
    }
    private func appendMonth(data: inout PayList?, yearIndex: Int, month: Int) -> PayList? {
        
        data?.years[yearIndex].months.append(PayList.Year.Month(month: month,
                                                           data: [PayList.Year.Month.Data]()))
        
        return data
    }
    
    // MARK: data 추가 및 수정
    func editData(division: String, data: inout PayList?, yearIndex: Int, monthIndex: Int, index: Int, value: PayList.Year.Month.Data) -> PayList? {
        
        switch division {
        case "추가하기":
            data?.years[yearIndex].months[monthIndex].data.insert(value, at: index)
            
            return sortedDate(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
        case "수정하기":
            data?.years[yearIndex].months[monthIndex].data[index] = value
            
            return sortedDate(data: &data, yearIndex: yearIndex, monthIndex: monthIndex)
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
    func sortedDate(data: inout PayList?, yearIndex: Int, monthIndex: Int) -> PayList? {
        
        let value = data?.years[yearIndex].months[monthIndex]
        data?.years[yearIndex].months[monthIndex].data = value?.data.sorted(by: {$0.date > $1.date}) ?? [PayList.Year.Month.Data]()
        
        return data
    }
    
    // MARK: 총 근무시간 계산
    func totalWorkCalcu(working: Int, workingMin: Int, over: Int, overMin: Int, night: Int, nightMin: Int, overNight: Int, overNightMin: Int) -> String {
        
        var hour: Int = hourCalcu(total: working, over: over, night: night, overNight: overNight)
        var min: Int = minCalcu(totalMin: workingMin, overMin: overMin, nightMin: nightMin, overNightMin: overNightMin)
        
        let convertHour: Int = min/60
        let remainderMin: Int = min%60
        
        hour = hour + convertHour
        min = remainderMin
        
        return "\(hour)시간 \(min)분"
    }
    private func hourCalcu(total: Int, over: Int, night: Int, overNight: Int) -> Int {
        
        let result: Int = total + over + night + overNight
        
        return result
    }
    private func minCalcu(totalMin: Int, overMin: Int, nightMin: Int, overNightMin: Int) -> Int {
        
        let result: Int = totalMin + overMin + nightMin + overNightMin
        
        return result
    }
    // MARK: 일 급여 계산
    func totalPaySum(working: Double, workingMin: Double, hourly: Double, over: Double, overMin: Double, night: Double, nightMin: Double, overNight: Double, overNightMin: Double) -> Int {
        
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
}

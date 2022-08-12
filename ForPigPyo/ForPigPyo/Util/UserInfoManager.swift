//
//  UserInfoManager.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/29.
//  Copyright © 2022 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa
import RxOptional


typealias WorkingTime = (hour: Int, min: Int)


class UserInfoManager {
    
    static let shared = UserInfoManager()
    
    private let bag = DisposeBag()
    
    let hourlyPay = PublishRelay<Int>()
    let workingTime = PublishRelay<WorkingTime>()
    let tax = PublishRelay<TaxCase>()
    let backup = PublishRelay<String?>()
    
    
    init() {
        self.hourlyPay
            .bind { [weak self] in self?.saveHourlyPay(sum: $0) }
            .disposed(by: bag)
        
        self.workingTime
            .bind { [weak self] in self?.saveWorkingTime($0) }
            .disposed(by: bag)
        
        self.tax
            .bind { [weak self] in self?.saveTax($0) }
            .disposed(by: bag)
    }
    
    private func saveHourlyPay(sum: Int) {
        UserDefaults.standard.set(sum, forKey: "MyPageVCHourly")
    }
    
    private func saveWorkingTime(_ time: WorkingTime?) {
        UserDefaults.standard.set(time?.hour, forKey: "myPageVCWorkHour")
        UserDefaults.standard.set(time?.min, forKey: "myPageVCWorkMin")
    }
    
    private func saveTax(_ tax: TaxCase?) {
        UserDefaults.standard.set(tax?.rawValue, forKey: "MyPageVCTax")
    }
    
    func getHourlyPay() -> Int {
        return UserDefaults.standard.integer(forKey: "MyPageVCHourly")
    }
    
    func getWorkingTime() -> WorkingTime {
        let hour = UserDefaults.standard.integer(forKey: "myPageVCWorkHour")
        let min = UserDefaults.standard.integer(forKey: "myPageVCWorkMin")
        
        return (hour, min)
    }
    
    func getTax() -> TaxCase {
        let tax = UserDefaults.standard.string(forKey: "MyPageVCTax") ?? "미공제"
        return TaxCase(rawValue: tax) ?? .free
    }
    
    func getBackup() -> String? {
        return UserDefaults.standard.string(forKey: "userID")
    }
    
    func loadInfo() {
        let defaultHourlyPay = getHourlyPay()
        hourlyPay.accept(defaultHourlyPay)
        
        let defaultWorkingTime = getWorkingTime()
        workingTime.accept(defaultWorkingTime)
        
        let defaultTax = getTax()
        tax.accept(defaultTax)
        
        let isBackup = getBackup()
        backup.accept(isBackup)
    }
}

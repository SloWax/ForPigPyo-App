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


class UserInfoManager {
    
    static let shared = UserInfoManager()
    
    private let bag = DisposeBag()
    
    let hourlyPay = PublishRelay<Int>()
    let workingTime = PublishRelay<(hour: Int, min: Int)>()
    let tax = PublishRelay<TaxCase>()
    
    
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
    
    private func loadHourlyPay() -> Int {
        return UserDefaults.standard.integer(forKey: "MyPageVCHourly")
    }
    
    private func saveWorkingTime(_ time: (hour: Int, min: Int)?) {
        UserDefaults.standard.set(time?.hour, forKey: "myPageVCWorkHour")
        UserDefaults.standard.set(time?.min, forKey: "myPageVCWorkMin")
    }
    
    private func loadWorkingTime() -> (hour: Int, min: Int) {
        let hour = UserDefaults.standard.integer(forKey: "myPageVCWorkHour")
        let min = UserDefaults.standard.integer(forKey: "myPageVCWorkMin")
        
        return (hour, min)
    }
    
    // 세금 index 저장
    private func saveTax(_ tax: TaxCase?) {
        UserDefaults.standard.set(tax?.rawValue, forKey: "MyPageVCTax")
    }
    
    // 세금 index 불러오기
    private func loadTax() -> TaxCase? {
        let tax = UserDefaults.standard.object(forKey: "MyPageVCTax")
        
        guard let tax = tax as? String else { return nil }
        
        return TaxCase(rawValue: tax)
    }
    
    func loadInfo() {
        let defaultHourlyPay = loadHourlyPay()
        hourlyPay.accept(defaultHourlyPay)
        
        let defaultWorkingTime = loadWorkingTime()
        workingTime.accept(defaultWorkingTime)
        
        if let defaultTax = loadTax() {
            tax.accept(defaultTax)
        }
    }
}

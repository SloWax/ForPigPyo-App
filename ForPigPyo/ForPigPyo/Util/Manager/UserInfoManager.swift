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


class UserInfoManager: NSObject {
    
    static let shared = UserInfoManager()
    
    private let bag = DisposeBag()
    private let calendar = Calendar.current
    private var components = DateComponents()
    
    let date = PublishRelay<Int>()
    let wage = PublishRelay<Int>()
    let workTime = PublishRelay<WorkingTime>()
    let tax = PublishRelay<TaxCase>()
    let login = PublishRelay<String?>()
    
    override init() {
        super.init()
        
        self.initCalendar()
        
        self.date
            .bind { [weak self] index in
                guard let self = self,
                      let month = self.components.month else { return }
                
                index == 0 ? self.initCalendar() : (self.components.month = month + index)
            }.disposed(by: bag)
        
        self.wage
            .bind { [weak self] in self?.saveWage($0) }
            .disposed(by: bag)
        
        self.workTime
            .bind { [weak self] in self?.saveWorkTime($0) }
            .disposed(by: bag)
        
        self.tax
            .bind { [weak self] in self?.saveTax($0) }
            .disposed(by: bag)
        
        self.login
            .bind { [weak self] in self?.saveLogin($0) }
            .disposed(by: bag)
    }
    
    private func saveWage(_ sum: Int) {
        UserDefaults.standard.set(sum, forKey: "MyPageVCHourly")
    }
    
    private func saveWorkTime(_ time: WorkingTime?) {
        UserDefaults.standard.set(time?.hour, forKey: "myPageVCWorkHour")
        UserDefaults.standard.set(time?.min, forKey: "myPageVCWorkMin")
    }
    
    private func saveTax(_ tax: TaxCase?) {
        UserDefaults.standard.set(tax?.rawValue, forKey: "MyPageVCTax")
    }
    
    private func saveLogin(_ identifier: String?) {
        UserDefaults.standard.set(identifier, forKey: "userID")
    }
    
    func getWage() -> Int {
        return UserDefaults.standard.integer(forKey: "MyPageVCHourly")
    }
    
    func getWorkTime() -> WorkingTime {
        let hour = UserDefaults.standard.integer(forKey: "myPageVCWorkHour")
        let min = UserDefaults.standard.integer(forKey: "myPageVCWorkMin")
        
        return (hour, min)
    }
    
    func getTax() -> TaxCase {
        let tax = UserDefaults.standard.string(forKey: "MyPageVCTax") ?? "미공제"
        return TaxCase(rawValue: tax) ?? .free
    }
    
    func getLogin() -> String? {
        return UserDefaults.standard.string(forKey: "userID")
    }
    
    func getSelectedDate() -> Date {
        return calendar.date(from: components) ?? Date()
    }
    
    func initCalendar() {
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
    }
    
    func loadInfo() {
        let defaultHourlyPay = getWage()
        wage.accept(defaultHourlyPay)
        
        let defaultWorkingTime = getWorkTime()
        workTime.accept(defaultWorkingTime)
        
        let defaultTax = getTax()
        tax.accept(defaultTax)
        
        let isLogin = getLogin()
        login.accept(isLogin)
    }
}

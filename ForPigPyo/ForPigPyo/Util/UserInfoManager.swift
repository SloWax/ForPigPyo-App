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
    
    enum UserDefaultKeys: String {
        case wage     = "wage"
        case workTime = "workTime"
        case tax      = "tax"
        case id       = "userID"
    }
    
    static let shared = UserInfoManager()
    
    private let bag = DisposeBag()
    private let calendar = Calendar.current
    private var components = DateComponents()
    
    let date = PublishRelay<Int>()
    let wage = PublishRelay<Int>()
    let workTime = PublishRelay<WorkTime>()
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
            .bind { [weak self] in self?.setUserDefaults($0, key: .wage) }
            .disposed(by: bag)
        
        self.workTime
            .bind { [weak self] in self?.setUserDefaults($0, key: .workTime) }
            .disposed(by: bag)
        
        self.tax
            .map { $0.rawValue }
            .bind { [weak self] in self?.setUserDefaults($0, key: .tax) }
            .disposed(by: bag)
        
        self.login
            .bind { [weak self] in self?.setUserDefaults($0, key: .id) }
            .disposed(by: bag)
    }
    
    private func setUserDefaults(_ value: Any?, key: UserDefaultKeys) {
        if let workTime = value as? WorkTime, key == .workTime {
            let combineTime = (workTime.hour * 60) + workTime.min
            
            UserDefaults.standard.set(combineTime, forKey: key.rawValue)
        } else {
            UserDefaults.standard.set(value, forKey: key.rawValue)
        }
    }
    
    func getWage() -> Int {
        return UserDefaults.standard.integer(forKey: "wage")
    }
    
    func getWorkTime() -> WorkTime {
        return UserDefaults.standard.integer(forKey: "workTime").splitTime
    }
    
    func getTax() -> TaxCase {
        let tax = UserDefaults.standard.string(forKey: "tax") ?? "미공제"
        return TaxCase(rawValue: tax) ?? .free
    }
    
    func getLogin() -> String? {
        return UserDefaults.standard.string(forKey: "userID")
    }
    
    func getTimeCardDate() -> Date {
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

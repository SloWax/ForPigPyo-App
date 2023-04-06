//
//  TimeCardVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/03/23.
//  Copyright © 2023 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


class TimeCardVM: BaseVM {
    struct Input {
        let bindRefresh = PublishRelay<Void>()
        let bindMove = PublishRelay<Int>()
        let bindChangeTax = PublishRelay<Void>()
    }
    
    struct Output {
        let bindValue = PublishRelay<(date: String, totalPay: Int, tax: String)>()
        let bindList = BehaviorRelay<[TimeCardModel.Attendance]>(value: [])
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        self.input
            .bindRefresh
            .bind { [weak self] in
                guard let self = self else { return }
                
                let date = UserInfoManager.shared
                    .getTimeCardDate()
                
                let list = DataManager.shared.retrieve()
                    .filter { $0.date.toString() == date.toString() }
                
                self.output.bindList.accept(list)
                
                let currentDate = date.toString()
                
                let totalPay = list
                    .reduce(into: 0) { result, attendance in
                        result += attendance.dayPay
                    }
                
                let tax = UserInfoManager.shared
                    .getTax()
                    .rawValue
                
                let value = (currentDate, totalPay, tax)
                
                self.output.bindValue.accept(value)
            }.disposed(by: bag)
        
        self.input
            .bindMove
            .map { UserInfoManager.shared.date.accept($0) }
            .bind(to: self.input.bindRefresh)
            .disposed(by: bag)
        
        self.input
            .bindChangeTax
            .map {
                let currentTax = UserInfoManager.shared.getTax()
                let taxCase = TaxCase.allCases
                let taxIndex = taxCase.firstIndex(of: currentTax) ?? 0
                let nextIndex = (taxIndex + 1) % taxCase.count
                let nextTax = taxCase[nextIndex]
                
                return UserInfoManager.shared.tax.accept(nextTax)
            }.bind(to: self.input.bindRefresh)
            .disposed(by: bag)
    }
}

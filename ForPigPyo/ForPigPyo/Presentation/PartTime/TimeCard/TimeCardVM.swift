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
    }
    
    struct Output {
        let bindValue = PublishRelay<(date: String, wage: Int, tax: String)>()
//        let bindList = BehaviorRelay<[Int]>(value: [0,1,1,2])
        let bindList = BehaviorRelay<[Int]>(value: [])
    }
    
    let input: Input
    let output: Output
    
    private let calendar = Calendar.current
    private var components = DateComponents()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        initCalendar()
        
        self.input
            .bindRefresh
            .bind { [weak self] in
                guard let self = self else { return }
                
                let currentDate = self.calendar
                    .date(from: self.components)?
                    .toString() ?? ""
                
                let wage = 0
                let tax = "미공제"
                
                let value = (currentDate, wage, tax)
                
                self.output.bindValue.accept(value)
            }.disposed(by: bag)
        
        self.input
            .bindMove
            .bind { [weak self] index in
                guard let self = self,
                      let month = self.components.month else { return }
                
                index == 0 ? self.initCalendar() : (self.components.month = month + index)
                
                self.input.bindRefresh.accept(Void())
            }.disposed(by: bag)
    }
    
    private func initCalendar() {
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
    }
}

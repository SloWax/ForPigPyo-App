//
//  OnlyDayModalVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/06.
//  Copyright © 2023 SloWax. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional


class OnlyDayModalVM: BaseVM {
    
    struct Input {
        // Void
        let loadData = PublishRelay<Void>()
        let bindIndex = PublishRelay<Int>()
        let bindConfirm = PublishRelay<Void>()
    }
    
    struct Output {
        // Void
        let bindDefaultRow = PublishRelay<(component: Int, row: Int)>()
        let bindConfirm = PublishRelay<Int>()
        
        // Data
        let days = BehaviorRelay<[Int]>(value: [])
    }
    
    let input: Input
    let output: Output
    
    private var selectedDay = 0
    
    init(input: Input = Input(), output: Output = Output(),
         defaultDay: Int) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .loadData
            .bind { [weak self] in
                guard let self = self else { return }
                
                let calendar = Calendar.current
                let date = UserInfoManager.shared.getTimeCardDate()
                
                let days = [Int](calendar.range(of: .day, in: .month, for: date)!)
                
                self.output.days.accept(days)
                
                if let row = days.firstIndex(of: defaultDay) {
                    self.selectedDay = days[row]
                    self.output.bindDefaultRow.accept((0, row))
                }
            }.disposed(by: bag)
        
        self.input
            .bindIndex
            .bind { [weak self] index in
                guard let self = self else { return }
                
                let days = self.output.days.value
                let selectValue = days[index]
                
                self.selectedDay = selectValue
            }.disposed(by: bag)
        
        self.input
            .bindConfirm
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.output.bindConfirm.accept(self.selectedDay)
            }.disposed(by: bag)
    }
}

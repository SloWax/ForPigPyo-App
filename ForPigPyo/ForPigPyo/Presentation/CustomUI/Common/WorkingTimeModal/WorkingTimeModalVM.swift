//
//  WorkingTimeModalVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/02.
//  Copyright © 2022 SloWax. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional


class WorkingTimeModalVM: BaseVM {
    
    struct Input {
        // Void
        let viewWillAppear = PublishRelay<Void>()
        let index = PublishRelay<(component: Int, row: Int)>()
        let bindConfirm = PublishRelay<Void>()
        
        // Data
        let selectedTime = BehaviorRelay<WorkingTime>(value: (0, 0))
    }
    
    struct Output {
        // Void
        let bindDefaultRow = PublishRelay<[(component: Int, row: Int)]>()
        let bindConfirm = PublishRelay<WorkingTime>()
        
        // Data
        let times = BehaviorRelay<[[Int]]>(value: [Array(0...23), Array(0...59)])
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output(),
         defaultTime: WorkingTime) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .viewWillAppear
            .bind { [weak self] in
                guard let self = self else { return }
                
                let times = self.output.times.value
                let hour = defaultTime.hour
                let min = defaultTime.min
                
                var rows: [(component: Int, row: Int)] = []
                
                if let row = times.first?.firstIndex(of: hour), hour > 0 {
                    rows.append((0, row))
                }
                
                if let row = times.last?.firstIndex(of: min), min > 0 {
                    rows.append((1, row))
                }
                
                guard rows.isNotEmpty else { return }
                
                self.input.selectedTime.accept((hour, min))
                self.output.bindDefaultRow.accept(rows)
            }.disposed(by: bag)
        
        self.input
            .index
            .bind { [weak self] index in
                guard let self = self else { return }
                
                let times = self.output.times.value
                let selectValue = times[index.component][index.row]
                
                var selectedTime = self.input.selectedTime.value
                let isHour = index.component == 0
                
                isHour ? (selectedTime.hour = selectValue) : (selectedTime.min = selectValue)
                self.input.selectedTime.accept(selectedTime)
            }.disposed(by: bag)
        
        self.input
            .bindConfirm
            .bind { [weak self] in
                guard let self = self else { return }
                
                let workingTime = self.input.selectedTime.value
                self.output.bindConfirm.accept(workingTime)
            }.disposed(by: bag)
    }
}

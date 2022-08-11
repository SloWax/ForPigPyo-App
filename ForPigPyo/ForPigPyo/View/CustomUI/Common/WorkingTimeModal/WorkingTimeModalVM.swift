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


class WorkingTimeModalVM: BaseVM {
    
    struct Input {
        // Void
        let index = PublishRelay<(component: Int, row: Int)>()
        let bindConfirm = PublishRelay<Void>()
        
        // Data
        let selectedTime = BehaviorRelay<(hour: Int, min: Int)>(value: (0, 0))
    }
    
    struct Output {
        // Void
        let bindConfirm = PublishRelay<(hour: Int, min: Int)>()
        
        // Data
        let times = BehaviorRelay<[[Int]]>(value: [Array(0...23), Array(0...59)])
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
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
            .bindConfirm // 근무시간 넘기기
            .bind { [weak self] in
                guard let self = self else { return }
                
                let workingTime = self.input.selectedTime.value
                self.output.bindConfirm.accept(workingTime)
            }.disposed(by: bag)
    }
}

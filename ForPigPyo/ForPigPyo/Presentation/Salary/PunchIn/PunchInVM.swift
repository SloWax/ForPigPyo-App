//
//  PunchInVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/04.
//  Copyright © 2023 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


class PunchInVM: BaseVM {
    
    enum RouteType {
        case create
        case edit
    }
    
    enum TimeType {
        case work
        case over
        case night
        case overNight
    }
    
    struct Input {
        let viewWillAppear = PublishRelay<Void>()
        let bindDate = BehaviorRelay<Int>(value: 0)
        let bindWage = BehaviorRelay<Int>(value: 0)
        let bindWorkingTime = PublishRelay<(type: TimeType, time: WorkingTime)>()
        let bindSave = PublishRelay<Void>()
    }
    
    struct Output {
        let bindDate = BehaviorRelay<Int>(value: 0)
        let bindWage = BehaviorRelay<Int>(value: 0)
        let bindWork = BehaviorRelay<WorkingTime>(value: (0, 0))
        let bindOver = BehaviorRelay<WorkingTime>(value: (0, 0))
        let bindNight = BehaviorRelay<WorkingTime>(value: (0, 0))
        let bindOverNight = BehaviorRelay<WorkingTime>(value: (0, 0))
        let bindTotal = BehaviorRelay<WorkingTime>(value: (0, 0))
        let bindDayPay = BehaviorRelay<Int>(value: 0)
    }
    
    let input: Input
    let output: Output
    
    private let calendar = Calendar.current
    private var components = DateComponents()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        self.input
            .viewWillAppear
            .bind { [weak self] in
                guard let self = self,
                      self.output.bindDate.value == 0 else { return }
                
                self.components.day = self.calendar.component(.day, from: Date())
                
                let date = self.calendar.date(from: self.components)?.toString(dateFormat: "dd") ?? "0"
                let today = Int(date) ?? 0
                
                self.output.bindDate.accept(today)
                
                let wage = UserInfoManager.shared.getHourlyPay()
                self.output.bindWage.accept(wage)
                
                let work = UserInfoManager.shared.getWorkingTime()
                self.input.bindWorkingTime.accept((.work, work))
            }.disposed(by: bag)
        
        self.input
            .bindWorkingTime
            .bind { [weak self] data in
                guard let self = self else { return }
                
                switch data.type {
                case .work      : self.output.bindWork.accept(data.time)
                case .over      : self.output.bindOver.accept(data.time)
                case .night     : self.output.bindNight.accept(data.time)
                case .overNight : self.output.bindOverNight.accept(data.time)
                }
                
                let work = self.output.bindWork.value
                let over = self.output.bindOver.value
                let night = self.output.bindNight.value
                let overNight = self.output.bindOverNight.value
                
                let total = [work, over, night, overNight]
                    .reduce(into: (0, 0)) { result, time in
                        result.0 += time.hour
                        result.1 += time.min
                    }
                
                self.output.bindTotal.accept(total)
                
                let dayPay = [work, over, night, overNight]
                    .map { self.convertTime($0) }
                    .enumerated()
                    .reduce(into: Float(0)) { result, time in
                        switch time.offset {
                        case 0  : result += self.calcuPay(time.element, multiple: 1)
                        case 1  : result += self.calcuPay(time.element, multiple: 1.5)
                        case 2  : result += self.calcuPay(time.element, multiple: 1.5)
                        case 3  : result += self.calcuPay(time.element, multiple: 2)
                        default : break
                        }
                    }
                
                self.output.bindDayPay.accept(Int(dayPay))
            }.disposed(by: bag)
        
    }
    
    private func convertTime(_ time: WorkingTime) -> Float {
        let hour = Float(time.hour)
        let min = Float(time.min / 60)
        return  hour + min
    }
    
    private func calcuPay(_ time: Float, multiple: Float) -> Float {
        let wage = Float(output.bindWage.value)
        return time * wage * multiple
    }
}

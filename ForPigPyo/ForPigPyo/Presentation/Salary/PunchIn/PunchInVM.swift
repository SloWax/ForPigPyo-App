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
    
    enum EventType {
        case wage
        case work
        case over
        case night
        case overNight
    }
    
    struct Input {
        let loadData = PublishRelay<Void>()
        let bindDate = PublishRelay<Int>()
        let bindWage = PublishRelay<Int>()
        let bindWorkTime = PublishRelay<(type: EventType, time: WorkTime)>()
        let bindSave = PublishRelay<Void>()
    }
    
    struct Output {
        let bindDate = BehaviorRelay<Int>(value: 0)
        let bindWage = BehaviorRelay<Int>(value: 0)
        let bindWork = BehaviorRelay<WorkTime>(value: (0, 0))
        let bindOver = BehaviorRelay<WorkTime>(value: (0, 0))
        let bindNight = BehaviorRelay<WorkTime>(value: (0, 0))
        let bindOverNight = BehaviorRelay<WorkTime>(value: (0, 0))
        let bindTotal = BehaviorRelay<WorkTime>(value: (0, 0))
        let bindDayPay = BehaviorRelay<Int>(value: 0)
        let bindBtnSaveIsEnabled = PublishRelay<Bool>()
        let bindSave = PublishRelay<Void>()
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
            .loadData
            .bind { [weak self] in
                guard let self = self,
                      self.output.bindDate.value == 0 else { return }
                
                self.components.day = self.calendar.component(.day, from: Date())
                
                let date = self.calendar.date(from: self.components)?.toString(dateFormat: "dd") ?? "0"
                let today = Int(date) ?? 0
                
                self.output.bindDate.accept(today)
                
                let wage = UserInfoManager.shared.getWage()
                self.output.bindWage.accept(wage)
                
                let work = UserInfoManager.shared.getWorkTime()
                self.input.bindWorkTime.accept((.work, work))
            }.disposed(by: bag)
        
        self.input
            .bindDate
            .bind(to: self.output.bindDate)
            .disposed(by: bag)
        
        self.input
            .bindWage
            .map { [weak self] wage in
                guard let self = self else { return }
                
                self.output.bindWage.accept(wage)
            }.map { (.wage, (0, 0)) }
            .bind(to: self.input.bindWorkTime)
            .disposed(by: bag)
        
        self.input
            .bindWorkTime
            .bind { [weak self] data in
                guard let self = self else { return }
                
                switch data.type {
                case .wage      : break
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
                
                let saveIsEnabled = dayPay > 0
                
                self.output.bindBtnSaveIsEnabled.accept(saveIsEnabled)
            }.disposed(by: bag)
        
        self.input
            .bindSave
            .bind { [weak self] in
                guard let self = self else { return }
                
                let timeCardDate = UserInfoManager.shared.getTimeCardDate()
                
                self.components.year = self.calendar.component(.year, from: timeCardDate)
                self.components.month = self.calendar.component(.month, from: timeCardDate)
                self.components.day = self.output.bindDate.value
                
                let selectedDate = self.calendar.date(from: self.components)
                let wage = self.output.bindWage.value
                let workTime = self.output.bindWork.value
                let overTime = self.output.bindOver.value
                let nightTime = self.output.bindNight.value
                let overNightTime = self.output.bindOverNight.value
                let total = self.output.bindTotal.value
                let dayPay = self.output.bindDayPay.value
                
                let attendance = AttendanceModel(
                    date: selectedDate ?? Date(),
                    wage: wage,
                    workTime: workTime,
                    overTime: overTime,
                    nightTime: nightTime,
                    overNightTime: overNightTime,
                    total: total,
                    dayPay: dayPay
                )
                
                print(attendance)
            }.disposed(by: bag)
    }
    
    private func convertTime(_ time: WorkTime) -> Float {
        let hour = Float(time.hour)
        let min = Float(time.min / 60)
        return  hour + min
    }
    
    private func calcuPay(_ time: Float, multiple: Float) -> Float {
        let wage = Float(output.bindWage.value)
        return time * wage * multiple
    }
}

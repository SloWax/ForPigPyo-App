//
//  TaxSelectModalVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/25.
//  Copyright © 2022 SloWax. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class TaxSelectModalVM: BaseVM {
    
    struct Input {
        // Void
        let inputTax = BehaviorRelay<TaxCase?>(value: nil)
        let setConfirm = PublishRelay<Void>()
        
        // Data
//        let tireWidth = BehaviorRelay<Int?>(value: nil)
//        let tireRadius = BehaviorRelay<Int?>(value: nil)
//        let tireInch = BehaviorRelay<Int?>(value: nil)
    }
    
    struct Output {
        // Void
        let outputTire = PublishRelay<TaxCase>()
        
        // Data
        let tireStandard = BehaviorRelay<TaxCase.AllCases.Type>(value: TaxCase.AllCases.self)
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
        // output 초기값
//        let standard = self.output.tireStandard.value
//        standard.enumerated().forEach { component, items in
//            let row = items.count / 2
//            switch component {
//            case 0 : input.tireWidth.accept(items[row])
//            case 1 : input.tireRadius.accept(items[row])
//            case 2 : input.tireInch.accept(items[row])
//            default: break
//            }
//        }
        
//        self.input
//            .inputTire // selectValue
//            .bind { [weak self] row, component in
//                guard let self = self else { return }
//
//                let standard = self.output.tireStandard.value[component]
//                let input = self.input
//
//                switch component {
//                case 0 : input.tireWidth.accept(standard[row])
//                case 1 : input.tireRadius.accept(standard[row])
//                case 2 : input.tireInch.accept(standard[row])
//                default: break
//                }
//            }.disposed(by: bag)
//
//        self.input
//            .setConfirm // 타이어 만들기
//            .bind { [weak self] in
//                guard let self = self,
//                      let width = self.input.tireWidth.value,
//                      let radius = self.input.tireRadius.value,
//                      let inch = self.input.tireInch.value else { return }
//
//                let tire = MyCarsDto.Response.Tire(width: width, radius: radius, inch: inch)
//                self.output.outputTire.accept(tire)
//            }.disposed(by: bag)
    }
}

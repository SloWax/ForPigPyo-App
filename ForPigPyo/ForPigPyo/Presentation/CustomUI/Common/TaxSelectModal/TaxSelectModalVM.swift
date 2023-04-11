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
        let loadData = PublishRelay<Void>()
        let bindConfirm = PublishRelay<Void>()
        
        // Data
        let selectedIndex = BehaviorRelay<Int>(value: 0)
    }
    
    struct Output {
        // Void
        let bindDefaultRow = PublishRelay<Int>()
        let outputTax = PublishRelay<TaxCase>()
        
        // Data
        let taxCases = BehaviorRelay<[TaxCase]>(value: TaxCase.allCases)
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .loadData
            .bind { [weak self] in
                guard let self = self else { return }
                
                let taxCases = self.output.taxCases.value
                let defaultTax = UserInfoManager.shared.getTax()
                
                guard let row = taxCases.firstIndex(of: defaultTax),
                      defaultTax != .free else { return }
                
                self.input.selectedIndex.accept(row)
                self.output.bindDefaultRow.accept(row)
            }.disposed(by: bag)
        
        self.input
            .bindConfirm // 공제율 넘기기
            .bind { [weak self] in
                guard let self = self else { return }
                
                let row = self.input.selectedIndex.value
                let tax = self.output.taxCases.value[row]
                self.output.outputTax.accept(tax)
            }.disposed(by: bag)
    }
}

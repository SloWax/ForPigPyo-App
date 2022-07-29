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
        let index = BehaviorRelay<Int>(value: 0)
        let setConfirm = PublishRelay<Void>()
    }
    
    struct Output {
        // Void
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
            .setConfirm // 공제율 넘기기
            .bind { [weak self] in
                guard let self = self else { return }
                
                let row = self.input.index.value
                let tax = self.output.taxCases.value[row]
                self.output.outputTax.accept(tax)
            }.disposed(by: bag)
    }
}

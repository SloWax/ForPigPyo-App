//
//  MyPageVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/21.
//  Copyright © 2022 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


class MyPageVM: BaseVM {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        super.init()
        
    }
}

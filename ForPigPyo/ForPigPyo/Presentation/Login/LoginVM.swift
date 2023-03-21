//
//  LoginVM.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/12.
//  Copyright © 2022 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


class LoginVM: BaseVM {
    struct Input { }
    
    struct Output {
        let bindCompLogin = PublishRelay<String?>()
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        UserInfoManager.shared
            .login
            .bind(to: self.output.bindCompLogin)
            .disposed(by: bag)
    }
}

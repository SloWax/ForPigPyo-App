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
        // Void
        let bindMenu = PublishRelay<MyPageModel.Menu>()
    }
    
    struct Output {
        // Void
        let bindMyInfo = PublishRelay<String>()
        let bindMenu = PublishRelay<MyPageModel.Menu>()
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .bindMenu
            .bind(to: self.output.bindMenu)
            .disposed(by: bag)
        
        UserInfoManager.shared.tax
            .bind { [weak self] tax in
                guard let self = self else { return }
                
                let tax = tax?.rawValue ?? "미설정"
                self.output.bindMyInfo.accept(tax)
            }.disposed(by: bag)
    }
}

struct MyPageModel {
    enum Menu {
        case wage
        case hour
        case tax
        case backup
    }
}

enum TaxCase: String, CaseIterable {
    case free = "미공제"
    case withholding = "3.3%"
    case insurance = "4대보험"
}

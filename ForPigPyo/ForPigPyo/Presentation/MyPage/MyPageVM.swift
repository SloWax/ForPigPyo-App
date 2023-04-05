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
import RxOptional


class MyPageVM: BaseVM {
    
    enum Menu {
        case wage
        case hour
        case tax
        case backup
    }
    
    struct Input {
        // Void
        let bindRefresh = PublishRelay<Void>()
        let bindMenu = PublishRelay<Menu>()
    }
    
    struct Output {
        // Void
        let bindMyWage = PublishRelay<String>()
        let bindMyWorkTime = PublishRelay<String>()
        let bindMyTax = PublishRelay<String>()
        let bindMyBackup = PublishRelay<String>()
        let bindMenu = PublishRelay<Menu>()
    }
    
    let input: Input
    let output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .bindRefresh
            .bind { UserInfoManager.shared.loadInfo() }
            .disposed(by: bag)
        
        self.input
            .bindMenu
            .filter { $0 == .backup ? !UserInfoManager.shared.getLogin().isNil : true }
            .bind(to: self.output.bindMenu)
            .disposed(by: bag)
        
        UserInfoManager.shared
            .wage
            .map { $0 == 0 ? "미설정" : ($0.comma.won) }
            .bind(to: self.output.bindMyWage)
            .disposed(by: bag)
        
        UserInfoManager.shared
            .workTime
            .map { workingTime in
                var text = ""
                
                if workingTime.hour > 0 { text = "\(workingTime.hour)시간" }
                if workingTime.min > 0 { text += " \(workingTime.min)분" }
                if text.count == 0 { text = "미설정" }
                
                return text
            }.bind(to: self.output.bindMyWorkTime)
            .disposed(by: bag)
        
        UserInfoManager.shared
            .tax
            .map { $0.rawValue }
            .bind(to: self.output.bindMyTax)
            .disposed(by: bag)
        
        UserInfoManager.shared
            .login
            .map { $0.isNil ? "미설정" : "동기화 중" }
            .bind(to: self.output.bindMyBackup)
            .disposed(by: bag)
    }
}

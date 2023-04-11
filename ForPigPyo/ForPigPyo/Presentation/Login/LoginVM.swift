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
import RxOptional


class LoginVM: BaseVM {
    struct Input {
        let bindLogin = PublishRelay<Void>()
        let bindRestore = PublishRelay<Bool>()
    }
    
    struct Output {
        let bindIsRestore = PublishRelay<Void>()
        let bindCompleteLogin = PublishRelay<Void>()
    }
    
    let input: Input
    let output: Output
    
    private var storedData: [TimeCardModel.Attendance]?
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        
        super.init()
        
        self.input
            .bindLogin
            .bind(to: SocialManager.shared.apple)
            .disposed(by: bag)
        
        self.input
            .bindRestore
            .bind { [weak self] isRestore in
                guard let self = self else { return }
                
                switch isRestore {
                case true :
                    let list = DataManager.shared.retrieve()
                    list.forEach { DataManager.shared.delete($0) }
                    
                    if let storedData = self.storedData {
                        storedData.forEach { DataManager.shared.create($0) }
                    }
                case false:
                    if let userID = UserInfoManager.shared.getLogin() {
                        FirebaseManager.shared.uploadDocument(userID)
                    }
                }
                
                self.output.bindCompleteLogin.accept(Void())
            }.disposed(by: bag)
        
        UserInfoManager.shared
            .login
            .filterNil()
            .bind { [weak self] userID in
                guard let self = self else { return }
                
                self.getDocument(userID) { findData in
                    switch findData {
                    case true :
                        self.output.bindIsRestore.accept(Void())
                    case false:
                        FirebaseManager.shared.uploadDocument(userID)
                        self.output.bindCompleteLogin.accept(Void())
                    }
                }
            }.disposed(by: bag)
    }
    
    private func getDocument(_ userID: String, storedData: @escaping (Bool) -> Void) {
        FirebaseManager.shared.getDocument(userID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let data = data {
                    
                    let convertData = data.data
                        .map {
                            let newItem = TimeCardModel.Attendance(
                                id: $0.id,
                                date: $0.date,
                                wage: $0.wage,
                                workTime: $0.workTime.splitTime,
                                overTime: $0.overTime.splitTime,
                                nightTime: $0.nightTime.splitTime,
                                overNightTime: $0.overNightTime.splitTime,
                                total: $0.total.splitTime,
                                dayPay: $0.dayPay
                            )
                            
                            return newItem
                        }
                    
                    self.storedData = convertData
                    storedData(true)
                } else {
                    FirebaseManager.shared.uploadDocument(userID)
                    storedData(false)
                }
            case .failure(let error):
                self.error.accept(error)
            }
        }
    }
}

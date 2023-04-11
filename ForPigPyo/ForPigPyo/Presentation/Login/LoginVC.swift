//
//  LoginVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxOptional
import RxGesture


class LoginVC: BaseVC {
    private let loginView = LoginView()
    private var vm: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> LoginVM {
        return LoginVM()
    }
    
    private func initialize() {
        view = loginView
        
        vm = setInputs()
    }
    
    private func bind() {
        loginView.btnApple
            .rx
            .tapGesture()
            .when(.recognized)
            .map { _ in Void() }
            .bind(to: vm.input.bindLogin)
            .disposed(by: vm.bag)
        
        vm.output
            .bindIsRestore
            .bind { [weak self] in
                guard let self = self else { return }
                
                let modal = TwoTapModalVC(
                    isEnabledTapDismiss: false,
                    title: "이전에 저장된 데이터를 찾았습니다 복구할까요?",
                    subTitle: "동기화 전 작성된 데이터는 삭제됩니다!!",
                    cancelTitle: "백업",
                    confirmTitle: "복구",
                    eventCancel: { self.vm.input.bindRestore.accept(false) },
                    eventConfirm: { self.vm.input.bindRestore.accept(true) }
                )
                
                self.presentVC(modal)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindCompleteLogin
            .observe(on: MainScheduler.asyncInstance)
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.clearBag(vm: self.vm)
                self.dismiss(animated: true)
            }.disposed(by: vm.bag)
    }
}

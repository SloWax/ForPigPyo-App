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
            .bind(to: SocialManager.shared.apple)
            .disposed(by: bag)
        
        vm.output
            .bindCompLogin
            .bind { [weak self] login in
                guard let self = self else { return }
                
                print(login ?? "nil") // 수정예정
                self.clearBag(vm: self.vm)
                self.dismiss(animated: true)
            }.disposed(by: bag)
    }
}

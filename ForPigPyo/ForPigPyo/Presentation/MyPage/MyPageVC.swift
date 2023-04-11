//
//  MyPageVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxOptional


class MyPageVC: BaseMainVC {
    private let myPageView = MyPageView()
    private var vm: MyPageVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> MyPageVM {
        return MyPageVM()
    }
    
    private func initialize() {
        title = "마이 페이지"
        
        view = myPageView
        
        vm = setInputs()
    }
    
    private func bind() {
        self.rx
            .viewWillAppear
            .bind(to: vm.input.bindRefresh)
            .disposed(by: vm.bag)
        
        myPageView.btnWage
            .rx
            .tap
            .map { .wage }
            .bind(to: vm.input.bindMenu)
            .disposed(by: vm.bag)
        
        myPageView.btnHour
            .rx
            .tap
            .map { .hour }
            .bind(to: vm.input.bindMenu)
            .disposed(by: vm.bag)
        
        myPageView.btnTax
            .rx
            .tap
            .map { .tax }
            .bind(to: vm.input.bindMenu)
            .disposed(by: vm.bag)
        
        myPageView.btnBackup
            .rx
            .tap
            .map { .backup }
            .bind(to: vm.input.bindMenu)
            .disposed(by: vm.bag)
        
        vm.output
            .bindMyWage
            .bind { [weak self] hourlyPay in
                guard let self = self else { return }
                
                self.myPageView.btnWage.setValue(value: hourlyPay)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindMyWorkTime
            .bind { [weak self] workTime in
                guard let self = self else { return }

                self.myPageView.btnHour.setValue(value: workTime)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindMyTax
            .bind { [weak self] tax in
                guard let self = self else { return }
                
                self.myPageView.btnTax.setValue(value: tax)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindMyBackup
            .bind { [weak self] isLogin in
                guard let self = self else { return }
                
                self.myPageView.btnBackup.setValue(value: isLogin)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindMenu
            .bind { [weak self] menu in
                guard let self = self else { return }
                
                switch menu {
                case .wage   : self.setWage()
                case .hour   : self.setWorkTime()
                case .tax    : self.setTax()
                case .backup : self.setBackup()
                }
            }.disposed(by: vm.bag)
    }
    
    private func setWage() {
        let placeholder = UserInfoManager.shared.getWage().comma
        
        let modal = TextFieldModalVC(
            title: "나의 시급 설정",
            subTitle: "급여 계산기에서 근무를 추가할 때\n시급이 자동 입력됩니다:)",
            placeholder: "\(placeholder) 원",
            tfType: .numberPad,
            validSum: (min: 0, max: Int.max),
            isFirstRespondse: true,
            onInput: { UserInfoManager.shared.wage.accept(Int($0) ?? 0) }
        )
        
        self.presentVC(modal)
    }
    
    private func setWorkTime() {
        let modal = WorkTimeModalVC(
            title: "근무 시간 설정",
            subTitle: "급여 계산기에서 근무를 추가할 때\n시간이 자동 입력됩니다:)",
            defaultTime: UserInfoManager.shared.getWorkTime(),
            onWorkTime: { UserInfoManager.shared.workTime.accept($0) }
        )
        
        self.presentVC(modal)
    }
    
    private func setTax() {
        let modal = TaxSelectModalVC(
            title: "세금 설정",
            onTax: { UserInfoManager.shared.tax.accept($0) }
        )
        
        self.presentVC(modal)
    }
    
    private func setBackup() {
        let vc = LoginVC()
        
        self.presentVC(vc, modal: .formSheet)
    }
}

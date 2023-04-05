//
//  PunchInVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/04.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxOptional


class PunchInVC: BaseSceneVC {
    private let punchInView = PunchInView()
    private var vm: PunchInVM!
    
    init(type: PunchInVM.RouteType) {
        super.init(nibName: nil, bundle: nil)
        
        switch type {
        case .create : setNavigationTitle(title: "근무 추가하기")
        case .edit   : setNavigationTitle(title: "근무 수정하기")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> PunchInVM {
        let inputs = PunchInVM()
        
        return inputs
    }
    
    private func initialize() {
        vm = setInputs()
        
        view = punchInView
    }
    
    private func bind() {
        self.rx
            .viewWillAppear
            .bind(to: vm.input.loadData)
            .disposed(by: vm.bag)
        
        punchInView.btnDate // 날짜
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callTodayModal()
            }.disposed(by: vm.bag)
        
        punchInView.btnWage // 시급
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callWageModal()
            }.disposed(by: vm.bag)
        
        punchInView.btnWork // 근무
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callWorkTimeModal(.work)
            }.disposed(by: vm.bag)
        
        punchInView.btnOver // 특근
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callWorkTimeModal(.over)
            }.disposed(by: vm.bag)
        
        punchInView.btnNight // 야근
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callWorkTimeModal(.night)
            }.disposed(by: vm.bag)
        
        punchInView.btnOverNight // 야/특근
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callWorkTimeModal(.overNight)
            }.disposed(by: vm.bag)
        
        punchInView.btnSave // 저장
            .rx
            .tap
            .bind(to: vm.input.bindSave)
            .disposed(by: vm.bag)
        
        vm.output
            .bindDate // bind 날짜
            .bind { [weak self] date in
                guard let self = self else { return }
                
                self.punchInView.setDateValue(date)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindWage // bind 시급
            .bind { [weak self] wage in
                guard let self = self else { return }
                
                self.punchInView.setWageValue(wage)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindWork // bind 근무시간
            .bind { [weak self] time in
                guard let self = self else { return }
                
                self.punchInView.setTimeValue(type: .work, data: time)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindOver // bind 특근시간
            .bind { [weak self] time in
                guard let self = self else { return }
                
                self.punchInView.setTimeValue(type: .over, data: time)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindNight // bind 야근시간
            .bind { [weak self] time in
                guard let self = self else { return }
                
                self.punchInView.setTimeValue(type: .night, data: time)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindOverNight // bind 야/특근시간
            .bind { [weak self] time in
                guard let self = self else { return }
                
                self.punchInView.setTimeValue(type: .overNight, data: time)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindTotal // bind 총 근무시간
            .bind { [weak self] time in
                guard let self = self else { return }
                
                self.punchInView.setTotalValue(data: time)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindDayPay // bind 일급
            .bind { [weak self] pay in
                guard let self = self else { return }
                
                self.punchInView.setDayPay(pay)
            }.disposed(by: vm.bag)
    }
    
    private func callTodayModal() {
        let workDay = vm.output.bindDate.value
        
        let modal = OnlyDayModalVC(
            title: "근무일",
            defaultDay: workDay,
            onSelectedDay: { [weak self] day in
                guard let self = self else { return }
                
                self.vm.input.bindDate.accept(day)
            }
        )
        
        presentVC(modal)
    }
    
    private func callWageModal() {
        let placeholder = vm.output.bindWage.value.comma
        
        let modal = TextFieldModalVC(
            title: "시급",
            placeholder: "\(placeholder) 원",
            tfType: .numberPad,
            validSum: (min: 0, max: Int.max),
            isFirstRespondse: true,
            onInput: { [weak self] in
                guard let self = self else { return }
                
                let wage = Int($0) ?? 0
                self.vm.input.bindWage.accept(wage)
            }
        )
        
        presentVC(modal)
    }
    
    private func callWorkTimeModal(_ type: PunchInVM.EventType) {
        let title: String
        let defaultTime: WorkingTime
        
        switch type {
        case .wage:
            return
        case .work:
            title = "근무"
            defaultTime = vm.output.bindWork.value
        case .over:
            title = "특근"
            defaultTime = vm.output.bindOver.value
        case .night:
            title = "야근"
            defaultTime = vm.output.bindNight.value
        case .overNight:
            title = "야/특근"
            defaultTime = vm.output.bindOverNight.value
        }
        
        let modal = WorkTimeModalVC(
            title: title,
            defaultTime: defaultTime,
            onWorkTime: { [weak self] time in
                guard let self = self else { return }
                
                let data = (type, time)
                self.vm.input.bindWorkTime.accept(data)
            }
        )
        
        presentVC(modal)
    }
}

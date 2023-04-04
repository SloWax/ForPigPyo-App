//
//  WorkingTimeModalVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/02.
//  Copyright © 2022 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional
import RxDataSources


typealias OnWorkingTime = (WorkingTime) -> Void


class WorkingTimeModalVC: BaseModalVC {
    
    private let textTitle: String
    private let textSubTitle: String?
    private let confirmTitle: String
    
    private var onWorkingTime: OnWorkingTime?
    
    private let workingTimeModalView = WorkingTimeModalView()
    private let vm: WorkingTimeModalVM
    
    private let stringPickerAdapter = RxPickerViewStringAdapter<[[Int]]>(
        components: [],
        numberOfComponents: { _, _, components in components.count },
        numberOfRowsInComponent: { _, _, items, row -> Int in
            return items[row].count
        },
        titleForRow: { _, _, items, row, component -> String? in
            var value = "\(items[component][row])"
            component == 0 ? (value += " 시간") : (value += " 분")
            
            return value
        }
    )
    
    init(title: String, subTitle: String? = nil,
         confirmTitle: String = "확인",
         defaultTime: WorkingTime,
         onWorkingTime: OnWorkingTime? = nil) {
        
        self.textTitle = title
        self.textSubTitle = subTitle
        self.confirmTitle = confirmTitle
        self.vm = WorkingTimeModalVM(defaultTime: defaultTime)
        self.onWorkingTime = onWorkingTime
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = workingTimeModalView
        
        workingTimeModalView.setValue(
            title: textTitle,
            subTitle: textSubTitle,
            confirmTitle: confirmTitle
        )
    }
    
    private func bind() {
        self.rx
            .viewWillAppear
            .bind(to: vm.input.viewWillAppear)
            .disposed(by: bag)
        
        workingTimeModalView.viewDismiss // 빈 공간 tap dismiss
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.clearBag(vm: self.vm)
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        workingTimeModalView.pvPicker // Picker value bind vm
            .rx
            .itemSelected
            .map { ($0.component, $0.row) }
            .bind(to: vm.input.index)
            .disposed(by: bag)
        
        workingTimeModalView.btnConfirm // 확인
            .rx
            .tap
            .bind(to: vm.input.bindConfirm)
            .disposed(by: bag)
        
        vm.output
            .times // 근무시간
            .bind(to: workingTimeModalView.pvPicker
                    .rx
                    .items(adapter: stringPickerAdapter)
            ).disposed(by: bag)
        
        vm.output
            .bindDefaultRow // 기본설정 row
            .bind { [weak self] defaultRow in
                guard let self = self else { return }
                
                self.workingTimeModalView.setDefaultRow(defaultRow)
            }.disposed(by: bag)
        
        vm.output
            .bindConfirm // 근무시간 넘기기
            .bind { [weak self] workingTime in
                guard let self = self else { return }
                
                if let callBack = self.onWorkingTime {
                    callBack(workingTime)
                }

                self.clearBag(vm: self.vm)
                self.dismiss(animated: false)
            }.disposed(by: bag)
    }
}

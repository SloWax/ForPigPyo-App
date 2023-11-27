//
//  OnlyDayModalVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/06.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional
import RxDataSources


class OnlyDayModalVC: BaseModalVC {
    
    private let textTitle: String
    private let textSubTitle: String?
    private let confirmTitle: String
    
    private var onSelectedDay: ((Int) -> Void)?
    
    private let onlyDayModalView = OnlyDayModalView()
    private let vm: OnlyDayModalVM
    
    private let stringPickerAdapter = RxPickerViewStringAdapter<[Int]>(
        components: [],
        numberOfComponents: { _, _, _ in 1 },
        numberOfRowsInComponent: { _, _, items, _ -> Int in items.count },
        titleForRow: { _, _, items, row, component -> String? in
            return "\(items[row]) 일"
        }
    )
    
    init(title: String, subTitle: String? = nil,
         confirmTitle: String = "확인",
         defaultDay: Int,
         onSelectedDay: ((Int) -> Void)? = nil) {
        
        self.textTitle = title
        self.textSubTitle = subTitle
        self.confirmTitle = confirmTitle
        self.vm = OnlyDayModalVM(defaultDay: defaultDay)
        self.onSelectedDay = onSelectedDay
        
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
        view = onlyDayModalView
        
        onlyDayModalView.setValue(
            title: textTitle,
            subTitle: textSubTitle,
            confirmTitle: confirmTitle
        )
    }
    
    private func bind() {
        self.rx
            .viewWillAppear
            .bind(to: vm.input.loadData)
            .disposed(by: bag)
        
        onlyDayModalView.viewDismiss // 빈 공간 tap dismiss
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.vm.clearBag()
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        onlyDayModalView.pvPicker // Picker value bind vm
            .rx
            .itemSelected
            .map { $0.row }
            .bind(to: vm.input.bindIndex)
            .disposed(by: bag)
        
        onlyDayModalView.btnConfirm // 확인
            .rx
            .tap
            .bind(to: vm.input.bindConfirm)
            .disposed(by: bag)
        
        vm.output
            .days // 근무일
            .bind(to: onlyDayModalView.pvPicker
                    .rx
                    .items(adapter: stringPickerAdapter)
            ).disposed(by: bag)
        
        vm.output
            .bindDefaultRow // 기본설정 row
            .bind { [weak self] defaultRow in
                guard let self = self else { return }
                
                self.onlyDayModalView.setDefaultRow(defaultRow)
            }.disposed(by: bag)
        
        vm.output
            .bindConfirm // 근무시간 넘기기
            .bind { [weak self] day in
                guard let self = self else { return }
                
                if let callBack = self.onSelectedDay {
                    callBack(day)
                }

                self.vm.clearBag()
                self.dismiss(animated: false)
            }.disposed(by: bag)
    }
}

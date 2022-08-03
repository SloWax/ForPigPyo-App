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


class WorkingTimeModalVC: BaseModalVC {
    
    private let textTitle: String
    private let confirmTitle: String
    
    private var onTax: OnTax?
    
    private let taxSelectModalView = WorkingTimeModalView()
    private var vm: WorkingTimeModalVM!
    
    private let stringPickerAdapter = RxPickerViewStringAdapter<[TaxCase]>(
        components: [],
        numberOfComponents: { _, _, _ in 1 },
        numberOfRowsInComponent: { _, _, items, _ -> Int in
            return items.count
        },
        titleForRow: { _, _, items, row, _ -> String? in
            items[row].rawValue
        }
    )
    
    init(title: String, confirmTitle: String = "확인", onTax: OnTax? = nil) {
        
        self.textTitle = title
        self.confirmTitle = confirmTitle
        self.onTax = onTax
        
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
    
    private func setInputs() -> WorkingTimeModalVM {
        return WorkingTimeModalVM()
    }
    
    private func initialize() {
        view = taxSelectModalView
        
        taxSelectModalView.setValue(title: textTitle, confirmTitle: confirmTitle)
        
        vm = setInputs()
    }
    
    private func bind() {
        taxSelectModalView.viewDismiss // 빈 공간 tap dismiss
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.clearBag(vm: self.vm)
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        taxSelectModalView.pvPicker // Picker value bind vm
            .rx
            .itemSelected
            .map { $0.row }
            .bind(to: vm.input.index)
            .disposed(by: bag)
        
        taxSelectModalView.btnConfirm // 확인
            .rx
            .tap
            .bind(to: vm.input.setConfirm)
            .disposed(by: bag)
        
        vm.output
            .taxCases // 세금 유형
            .bind(to: taxSelectModalView.pvPicker
                    .rx
                    .items(adapter: stringPickerAdapter)
            ).disposed(by: bag)
        
        vm.output
            .outputTax // 공제율 넘기기
            .bind { [weak self] tax in
                guard let self = self else { return }

                if let callBack = self.onTax {
                    callBack(tax)
                }

                self.clearBag(vm: self.vm)
                self.dismiss(animated: false)
            }.disposed(by: bag)
    }
}

//
//  TaxSelectModalVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/25.
//  Copyright © 2022 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional
import RxDataSources


typealias OnTax = (TaxCase) -> Void


class TaxSelectModalVC: BaseModalVC {
    
    private let textTitle: String
    private let confirmTitle: String
    
    private var onTax: OnTax?
    
    private let taxSelectModalView = TaxSelectModalView()
    private var vm: TaxSelectModalVM!
    
    private let stringPickerAdapter = RxPickerViewStringAdapter<[TaxCase]>(
        components: [],
        numberOfComponents: { _, _, _ in 1 },
        numberOfRowsInComponent: { _, _, items, _ -> Int in
            return items.count
        },
        titleForRow: { _, _, items, row, _ -> String? in
//            component == 1 ? "\(items[component][row])R" : "\(items[component][row])"
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
    
    private func setInputs() -> TaxSelectModalVM {
        return TaxSelectModalVM()
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

//extension MyPageVC: UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//        return MyPageData.taxCategory.count + 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        var result: String?
//
//        row == 0 ? (result = "---- 목록 ----") : (result = MyPageData.taxCategory[row - 1])
//
//        return result
//    }
//}
//
//extension MyPageVC: UIPickerViewDelegate {
//    // 선택된 row의 index 값을 UserDefaults에 저장하여 PartTimeVC load 시 설정, 만약 tabBar에서 PartTimeVC가 load되어 있을 경우 해당 VC를 찾아서 값 넘겨줌
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        row == 0 ? model.saveTax(data: nil, forKey: MyPageData.MyPageVCTax) : model.saveTax(data: row - 1, forKey: MyPageData.MyPageVCTax)
//
//        if let partVC = tabBarController?.viewControllers?[0].children.last as? PartTimeVC {
//            var row = row
//            if row == 0 { row = 1 }
//
//            partVC.taxIndex = row - 1
//            partVC.partTimeView.setButtonTitle(title: MyPageData.taxCategory[partVC.taxIndex])
//            partVC.loadPartTimeValue(deduction: partVC.taxIndex % partVC.tax.count)
//        }
//
//        myPageView.tvList.reloadData()
//    }
//}

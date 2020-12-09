//
//  MyPageVCPickerView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/09.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension MyPageVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return MyPageData.taxCategory.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result: String?
        
        row == 0 ? (result = "---- 목록 ----") : (result = MyPageData.taxCategory[row - 1])
        
        return result
    }
}

extension MyPageVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        row == 0 ? model.saveTax(data: nil, forKey: MyPageData.MyPageVCTax) : model.saveTax(data: row - 1, forKey: MyPageData.MyPageVCTax)
        
        guard row != 0 else { return }
        
        if let partVC = tabBarController?.viewControllers?[0].children.last as? PartTimeVC {
            
            partVC.taxIndex = row - 1
            partVC.partTimeView.setButtonTitle(title: MyPageData.taxCategory[partVC.taxIndex])
            partVC.loadPartTimeValue(deduction: partVC.taxIndex % partVC.tax.count)
        }
    }
}

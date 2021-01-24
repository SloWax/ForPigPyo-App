//
//  MyPageVCTableView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension MyPageVC: UITableViewDataSource {
    
    // section 별 메뉴 설정 추후 업데이트 시 section 추가되면 활성화 예정
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//        return menuData.menu.count - 2
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageHeaderCustomSection.identifier) as? MyPageHeaderCustomSection else { fatalError() }
//        header.setValue(title: menuData.menu[section].title)
//
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//        view.tintColor = .clear
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuData.menu[section].myPageMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else { fatalError() }
        
        let sectionIV = menuData.menu[indexPath.section]
        var value: String?
        // section 별 메뉴, 추후 업데이트 시 추가되면 설정 예정
//        if indexPath.section == 0 {
        switch indexPath.row {
        case 0:
            
            value = model.loadHourly(forKey: MyPageData.myPageVCHourly)
        case 1:
            
            if let hour = model.loadHourly(forKey: MyPageData.myPageVCWorkHour) {
                
                value = "\(hour)시간"
                if let min = model.loadHourly(forKey: MyPageData.myPageVCWorkMin) {
                    
                    value = "\(hour)시간 \(min)분"
                }
            } else if let min = model.loadHourly(forKey: MyPageData.myPageVCWorkMin) {
                
                value = "\(min)분"
            } else {
                
                value = nil
            }
        case 2:
            
            if let index = model.loadTax(forKey: MyPageData.MyPageVCTax) {
                value = MyPageData.taxCategory[index]
            }
        default:
            fatalError()
        }
//        }
        cell.setValue(image: sectionIV.myPageMenu[indexPath.row].image,
                      title: sectionIV.myPageMenu[indexPath.row].title,
                      value: value,
                      row: indexPath.row)
        
        return cell
    }
}

extension MyPageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 2 {
            
            taxPickerView.pickerView.selectRow(0, inComponent: 0, animated: true)
            moveTaxPicker(offset: 0)
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MyPageCustomCell else { fatalError() }
        
//        switch indexPath.section {
//        case 0:
            // cell 별 Action
            switch indexPath.row {
            case 0:
                let alert = UIAlertController(title: cell.titleLabel.text, message: "급여 계산기에서 근무를 추가할 때\n시급이 자동 입력됩니다:)", preferredStyle: .alert)
                let noButton = UIAlertAction(title: "취소", style: .default) { (_ ) in
                    
                    alert.textFields?[0].resignFirstResponder()
                }
                let okButton = UIAlertAction(title: "저장", style: .default) { (_ ) in
                    
                    self.model.saveHourly(data: alert.textFields?[0].text ?? "", forKey: MyPageData.myPageVCHourly)
                    self.myPageView.tableView.reloadData()
                    
                    alert.textFields?[0].resignFirstResponder()
                }
                
                alert.addTextField { (textField) in
                    
                    let formatter: NumberFormatter = {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        
                        return formatter
                    }()
                    let value = self.model.loadHourly(forKey: MyPageData.myPageVCHourly)
                    let intValue = Int(value ?? "") ?? 0
                    let placeholder = formatter.string(from: NSNumber(value: intValue)) ?? ""
                    
                    textField.placeholder = "\(placeholder) 원"
                    textField.keyboardType = .numberPad
                    textField.doneAccessory = true
                }
                alert.addAction(noButton)
                alert.addAction(okButton)
                
                present(alert, animated: true)
            case 1:
                
                let alert = UIAlertController(title: cell.titleLabel.text, message: "급여 계산기에서 근무를 추가할 때\n근무시간이 자동 입력됩니다:)", preferredStyle: .alert)
                let noButton = UIAlertAction(title: "취소", style: .default) { (_ ) in
                    
                    (0...1).forEach { (index) in
                        
                        alert.textFields?[index].resignFirstResponder()
                    }
                }
                let okButton = UIAlertAction(title: "저장", style: .default) { (_ ) in
                    
                    let textFields = alert.textFields
                    self.model.saveWorkTime(hour: textFields?[0].text ?? "",
                                            min: textFields?[1].text ?? "",
                                            forKeyHour: MyPageData.myPageVCWorkHour,
                                            forKeyMin: MyPageData.myPageVCWorkMin)
                    
                    self.myPageView.tableView.reloadData()
                    
                    (0...1).forEach { (index) in
                        
                        alert.textFields?[index].resignFirstResponder()
                    }
                }
                
                alert.addTextField { (textField) in
                    
                    textField.placeholder = "시간"
                    textField.keyboardType = .numberPad
                    textField.doneAccessory = true
                    textField.addTarget(self, action: #selector(self.textCountLimit(_:)), for: .editingChanged)
                }
                alert.addTextField { (textField) in
                    
                    textField.placeholder = "분"
                    textField.keyboardType = .numberPad
                    textField.doneAccessory = true
                    textField.addTarget(self, action: #selector(self.textCountLimit(_:)), for: .editingChanged)
                }
                alert.addAction(noButton)
                alert.addAction(okButton)
                
                present(alert, animated: true)
            case 2:
                
                moveTaxPicker(offset: -self.taxPickerView.frame.height)
            default:
                fatalError()
            }
//        default:
//            fatalError()
//        }
    }
}

//
//  MyPageVCTableView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension MyPageVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return menuData.menu.count - 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageHeaderCustomSection.identifier) as? MyPageHeaderCustomSection else { fatalError() }
        header.setValue(title: menuData.menu[section].title)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuData.menu[section].myPageMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else { fatalError() }
        
        let sectionIV = menuData.menu[indexPath.section]
        var value: String? = nil
        // section 별 메뉴 설정 추후 업데이트 시 section 추가되면 switch문으로 변경 예정
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                
                value = model.loadHourly(forKey: MyPageData.myPageVCHourly)
            } else {
                
                if let index = model.loadTax(forKey: MyPageData.MyPageVCTax) {
                    value = MyPageData.taxCategory[index]
                }
            }
        }
        cell.setValue(image: sectionIV.image,
                      title: sectionIV.myPageMenu[indexPath.row],
                      value: value,
                      row: indexPath.row)
        
        return cell
    }
}

extension MyPageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 1 {
            
            moveTaxPicker(offset: 0)
            taxPickerView.pickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MyPageCustomCell else { fatalError() }
        
        switch indexPath.section {
        case 0:
            // cell 별 Action
            switch indexPath.row {
            case 0:
                let alert = UIAlertController(title: cell.titleLabel.text, message: "자동 입력을 위해 시급을 넣어주세요.", preferredStyle: .alert)
                let noButton = UIAlertAction(title: "취소", style: .default) { (_ ) in
                    
                    alert.textFields?[0].resignFirstResponder()
                }
                let okButton = UIAlertAction(title: "저장", style: .default) { (_ ) in
                    
                    self.model.saveHourly(data: alert.textFields?[0].text ?? "", forKey: MyPageData.myPageVCHourly)
                    self.myPageTable.reloadData()
                    
                    alert.textFields?[0].resignFirstResponder()
                }
                
                alert.addTextField { (textField) in
                    
                    textField.keyboardType = .numberPad
                    textField.doneAccessory = true
                }
                alert.addAction(noButton)
                alert.addAction(okButton)
                
                present(alert, animated: true)
            case 1:
                
                moveTaxPicker(offset: -self.taxPickerView.frame.height)
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
}

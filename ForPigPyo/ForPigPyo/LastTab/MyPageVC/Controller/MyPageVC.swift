//
//  MyPageVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class MyPageVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    lazy var myPageView: MyPageView = {
        let view = MyPageView()
        
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.register(MyPageCustomCell.self, forCellReuseIdentifier: MyPageCustomCell.identifier)
        view.tableView.register(MyPageHeaderCustomSection.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderCustomSection.identifier)
        
        return view
    }()
    lazy var taxPickerView: DonePickerView = {
        let picker = DonePickerView()
        picker.pickerView.dataSource = self
        picker.pickerView.delegate = self
        
        return picker
    }()
    
    let model = MyPageVCModel()
    var menuData: HomeVCModel = HomeVCModel(menu: [HomeVCModel.Menu]())
    var constraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let partVC = tabBarController?.viewControllers?[0].children.last as? PartTimeVC {
            
            taxPickerView.pickerView.selectRow((partVC.taxIndex % partVC.tax.count) + 1, inComponent: 0, animated: true)
            myPageView.tableView.reloadData()
        }
    }
    // set View
    private func setView() {
        
        navigationItem.title = "마이 페이지"
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        taxPickerView.doneButton.action = #selector(taxPickerDone(_:))
        view.addSubview(taxPickerView)
        
        taxPickerView.snp.makeConstraints {
            
            constraint = $0.top.equalTo(view.snp_bottomMargin).constraint
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func moveTaxPicker(offset: CGFloat) {
        // pickerView animation
        UIView.animate(withDuration: 0.25) {
            
            self.constraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
        myPageView.tableView.reloadData()
    }
    @objc func textCountLimit(_ sender: UITextField) {
        
        guard sender.text?.count ?? 0 < 3  else { return sender.deleteBackward() }
    }
    @objc private func taxPickerDone(_ sender: UIBarButtonItem) {
        // picker doneButton Action
        moveTaxPicker(offset: 0)
    }
}

extension MyPageVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuData.menu[section].myPageMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else { fatalError() }
        
        let sectionIV = menuData.menu[indexPath.section]
        var value: String?
        
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
    }
}

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
    // 선택된 row의 index 값을 UserDefaults에 저장하여 PartTimeVC load 시 설정, 만약 tabBar에서 PartTimeVC가 load되어 있을 경우 해당 VC를 찾아서 값 넘겨줌
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        row == 0 ? model.saveTax(data: nil, forKey: MyPageData.MyPageVCTax) : model.saveTax(data: row - 1, forKey: MyPageData.MyPageVCTax)
        
        if let partVC = tabBarController?.viewControllers?[0].children.last as? PartTimeVC {
            var row = row
            if row == 0 { row = 1 }
            
            partVC.taxIndex = row - 1
            partVC.partTimeView.setButtonTitle(title: MyPageData.taxCategory[partVC.taxIndex])
            partVC.loadPartTimeValue(deduction: partVC.taxIndex % partVC.tax.count)
        }
        
        myPageView.tableView.reloadData()
    }
}

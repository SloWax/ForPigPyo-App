//
//  AddSavingVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class AddSavingVC: UIViewController {
    
    let savingAddEditView: SavingAddEditView = {
        let view = SavingAddEditView()
        
        return view
    }()
    let datePickerView: DoneMonthYearPickerView = {
        let view = DoneMonthYearPickerView()

        return view
    }()
    
    private let formatter = DateFormatter()
    private var year: String = ""
    private var month: String = ""
    private lazy var dateBundle = [year, month]
    
    var data: SavingList?
    private let model = SavingVCModel()
    private var viewConstraint: Constraint?
    private var pickerConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setView()
    }
    
    private func setView() {
        
        view.backgroundColor = .systemBackground
        
        savingAddEditView.saveDateView.buttonBundle.forEach {
            
            $0.addTarget(self, action: #selector(dateButton(_:)), for: .touchUpInside)
        }
        savingAddEditView.saveButton.addTarget(self, action: #selector(saveButton(_:)), for: .touchUpInside)
        savingAddEditView.saveSumView.textField1.addTarget(self, action: #selector(doneDate(_:)), for: .editingDidBegin)
        view.addSubview(savingAddEditView)
        
        savingAddEditView.snp.makeConstraints {
            
            viewConstraint = $0.top.equalTo(view.safeAreaLayoutGuide).constraint
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        datePickerView.monthYearPicker.onDateSelected = { (year: Int, month: Int) in
            self.formatter.dateFormat = "yyyy-MM"
            
            let date = self.formatter.date(from: "\(year)-\(month)")
            self.setDate(date: date ?? Date())
    }
        datePickerView.doneButton.action = #selector(doneDate(_:))
        view.addSubview(datePickerView)
        
        datePickerView.snp.makeConstraints {
            $0.height.equalTo(savingAddEditView).multipliedBy(0.2)
            pickerConstraint = $0.top.equalTo(view.snp_bottomMargin).constraint
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func moveDatePicker(offset: CGFloat) {
        // datePicker animation
        UIView.animate(withDuration: 0.25) {
            
            self.pickerConstraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
    }
    
    func setDate(date: Date) {
        
        formatter.dateFormat = "yyyy"
        year = formatter.string(from: date)
        savingAddEditView.saveDateView.button1.setTitle(year, for: .normal)
        
        formatter.dateFormat = "MM"
        month = formatter.string(from: date)
        savingAddEditView.saveDateView.button2.setTitle(month, for: .normal)
    }
    
    @objc private func dateButton(_ sender: UIButton) {
        
        savingAddEditView.saveSumView.textField1.resignFirstResponder()
        moveDatePicker(offset: -self.datePickerView.frame.height)
    }
    @objc private func keyboardNotification(_ sender: NSNotification) {
        
        switch sender.name {
        case UIResponder.keyboardWillShowNotification:
            
            if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 0.5) {
                    
                    self.viewConstraint?.update(offset: -keyboardSize.height / 2)
                    self.view.layoutIfNeeded()
                }
            }
        case UIResponder.keyboardWillHideNotification:
            
            UIView.animate(withDuration: 0.5) {
                
                self.viewConstraint?.update(offset: 0)
                self.view.layoutIfNeeded()
            }
        default:
            fatalError()
        }
    }
    @objc private func doneDate(_ sender: UIBarButtonItem) {
        
        moveDatePicker(offset: 0)
    }
    @objc private func saveButton( _ sender: UIButton) {
        
        let division = savingAddEditView.titleLabel
        
        let saveDate = savingAddEditView.saveDateView
        let year = saveDate.button1.titleLabel?.text ?? ""
        let month = saveDate.button2.titleLabel?.text ?? ""
        let saving = Int(savingAddEditView.saveSumView.textField1.text ?? "") ?? 0
        
        let value = SavingList.Data(year: year,
                                    month: month,
                                    saving: saving)
        
        data = model.editData(division: division.text ?? "", data: &data, saveIndex: division.tag, value: value)
        model.saveData(data: data ?? SavingList(aimSaving: 0, aimDate: "", data: [SavingList.Data]()))
        
        if let savingAdminVC = self.navigationController?.viewControllers[2] as? SavingAdminVC {
            
            savingAdminVC.data = data
            savingAdminVC.reloadData(data: savingAdminVC.data)
        }
        
        if let savingVC = self.navigationController?.viewControllers[1] as? SavingVC {
            
            savingVC.data = data
            savingVC.reloadData(data: savingVC.data)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

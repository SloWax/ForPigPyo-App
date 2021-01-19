//
//  SetAimVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class SetAimVC: UIViewController {
    
    let setAimView: SetAimView = {
        let view = SetAimView()
        
        return view
    }()
    let datePickerView: DoneDatePickerView = {
        let view = DoneDatePickerView()
            view.datePicker.datePickerMode = .date
        
        return view
    }()
    
    private let formatter = DateFormatter()
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    private lazy var dateBundle = [year, month, day]
    
    private var constraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    private func setView() {
        
        view.backgroundColor = .systemBackground
        
        setAimView.untilDateView.buttonBundle.forEach {
            
            $0.addTarget(self, action: #selector(untilDate(_:)), for: .touchUpInside)
        }
        setAimView.saveButton.addTarget(self, action: #selector(saveButton(_:)), for: .touchUpInside)
        setAimView.myAimView.textField1.addTarget(self, action: #selector(doneDate(_:)), for: .editingDidBegin)
        view.addSubview(setAimView)
        
        setAimView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        datePickerView.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePickerView.doneButton.action = #selector(doneDate(_:))
        view.addSubview(datePickerView)
        
        datePickerView.snp.makeConstraints {
            $0.height.equalTo(setAimView).multipliedBy(0.2)
            constraint = $0.top.equalTo(view.snp_bottomMargin).constraint
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func moveDatePicker(offset: CGFloat) {
        // datePicker animation
        UIView.animate(withDuration: 0.25) {
            
            self.constraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
    }
    
    func setDate(date: Date) {
        
        formatter.dateFormat = "yyyy"
        year = formatter.string(from: date)
        setAimView.untilDateView.button1.setTitle(year, for: .normal)
        
        formatter.dateFormat = "MM"
        month = formatter.string(from: date)
        setAimView.untilDateView.button2.setTitle(month, for: .normal)
        
        formatter.dateFormat = "dd"
        day = formatter.string(from: date)
        setAimView.untilDateView.button3.setTitle(day, for: .normal)
    }
    
    @objc private func untilDate(_ sender: UIButton) {
        
        setAimView.myAimView.textField1.resignFirstResponder()
        moveDatePicker(offset: -self.datePickerView.frame.height)
    }
    @objc private func dateChanged() {
        
        setDate(date: datePickerView.datePicker.date)
    }
    @objc private func doneDate(_ sender: UIBarButtonItem) {
        
        moveDatePicker(offset: 0)
    }
    @objc private func saveButton( _ sender: UIButton) {
        
        if let savingVC = self.navigationController?.viewControllers[1] as? SavingVC {
            
            savingVC.data?.aimSaving = Int(setAimView.myAimView.textField1.text ?? "") ?? 0
            savingVC.data?.aimDate = "\(year)-\(month)-\(day)"
            
            savingVC.model.saveData(data: savingVC.data ?? SavingList(aimSaving: 0, aimDate: "", data: [SavingList.Data]()))
            savingVC.reloadData(data: savingVC.data)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

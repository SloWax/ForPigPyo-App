//
//  PartTimeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class PartTimeVC: UIViewController {
    
    static let forkey: String = "PartTimeVC"
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.purple
        
        return imageView
    }()
    lazy var partTimeView: PartTimeView = {
        let view = PartTimeView()
        [view.preButton, view.nexButton].forEach { (button) in
            button.addTarget(self, action: #selector(moveTable(_:)), for: .touchUpInside)
        }
        view.historyTable.delegate = self
        view.historyTable.dataSource = self
        view.historyTable.register(PartTimeCustomCell.self, forCellReuseIdentifier: PartTimeCustomCell.identifier)
        
        return view
    }()
    private let yearFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        
        return format
    }()
    private let monthFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "MM"
        
        return format
    }()
    private let saveView: PartTimeSaveView = {
        let view = PartTimeSaveView()
        
        return view
    }()
    
    private var constraint: Constraint?
    let model = PartTimeVCModel()
    var data: PayList?
    
    let tax: [String] = MyPageVCModel.taxCategory
    var taxIndex: Int = 0
    
    private lazy var yearInt = Int(yearFormat.string(from: Date())) ?? 0
    private lazy var monthInt = Int(monthFormat.string(from: Date())) ?? 0
    var yearIndex: Int = 0
    var monthIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setView()
        setPartTimeView()
        setSaveView()
    }
    private func setDateIndex() {
        
        yearIndex = (data?.years.endIndex ?? 1) - 1
        monthIndex = (data?.years[yearIndex].months.endIndex ?? 1) - 1
    }
    private func setData() {
        
        data = model.loadData() ?? PayList(years: [PayList.Year(year: yearInt,
                                                                months: [PayList.Year.Month(month: monthInt,
                                                                                            data: [PayList.Year.Month.Data]())])])
        setDateIndex()
        data = model.checkDataTable(data: &data, yearIndex: yearIndex, monthIndex: monthIndex, yearInt: yearInt, monthInt: monthInt)
        setDateIndex()
    }
    private func setView() {
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addSaveView(_:)))
        navigationItem.rightBarButtonItem = rightButton
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setPartTimeView() {
        
        partTimeView.setButtonTitle(title: tax[taxIndex])
        partTimeView.taxButton.addTarget(self, action: #selector(changeDeduction(_:)), for: .touchUpInside)
        view.addSubview(partTimeView)
        
        partTimeView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
    }
    private func setSaveView() {
        
        [saveView.dateTextField, saveView.workingTextField, saveView.workingMinTextField, saveView.overTextField,
         saveView.overMinTextField, saveView.nightTextField, saveView.nightMinTextField, saveView.overNightTextField,
         saveView.overNightMinTextField].forEach { (textField) in
            
            textField.addTarget(self, action: #selector(textCountLimit(_:)), for: .editingChanged)
        }
        
        [saveView.cancleButton, saveView.saveButton].forEach({ (button) in
            
            button.addTarget(self, action: #selector(returnSaveView(_:)), for: .touchUpInside)
        })
        view.addSubview(saveView)

        saveView.snp.makeConstraints {
            $0.top.equalTo(partTimeView.totalLabel)
            $0.width.equalToSuperview()
            constraint = $0.leading.equalTo(view.snp.trailing).constraint
        }
    }
    
    private func moveSaveView(offset: CGFloat) {

        UIView.animate(withDuration: 0.25) {

            self.constraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
    }
    private func setLabelAlpha(label: UILabel, value: CGFloat) {
        
        UIView.animate(withDuration: 0.25) {
            
            label.alpha = value
        }
    }
    
    func loadSaveView(isAdd: Bool, yearIndex: Int, monthIndex: Int, index: Int, title: String) {
        
        if isAdd == true {
                let format = DateFormatter()
                format.dateFormat = "dd"
            
            saveView.setValue(title: title, date: format.string(from: Date()), index: index, value: nil)
        } else {
            
            saveView.setValue(title: title, date: nil, index: index, value: data?.years[yearIndex].months[monthIndex].data[index])
        }
        
        moveSaveView(offset: -view.frame.width)
    }
    func loadPartTimeValue(deduction: Int) {
        
        let date = data?.years[yearIndex]
        let year = date?.year ?? 0
        let month = date?.months[monthIndex].month ?? 0
        let total = model.setTotalPay(data: data, yearIndex: yearIndex, monthIndex: monthIndex, deduction: deduction)
        
        partTimeView.setValue(year: year, month: month, totalPay: total)
    }
    
    @objc private func addSaveView(_ sender: UIButton) {
        
        loadSaveView(isAdd: true, yearIndex: yearIndex, monthIndex: monthIndex, index: 0, title: "추가하기")
    }
    @objc private func moveTable(_ sender: UIButton) {
        
        switch sender {
        case partTimeView.preButton:
            
            if data?.years[yearIndex].months.startIndex != monthIndex {
                
                monthIndex -= 1
            } else if data?.years[yearIndex].months.startIndex == monthIndex, data?.years.startIndex != yearIndex {
                
                yearIndex -= 1
                monthIndex = (data?.years[yearIndex].months.endIndex ?? 1) - 1
            } else {
                
                return
            }
            
        case partTimeView.nexButton:
            
            if (data?.years[yearIndex].months.endIndex ?? 1) - 1 != monthIndex {
                
                monthIndex += 1
            } else if (data?.years[yearIndex].months.endIndex ?? 1) - 1 == monthIndex, (data?.years.endIndex ?? 1) - 1 != yearIndex {
                
                yearIndex += 1
                monthIndex = data?.years[yearIndex].months.startIndex ?? 0
            } else {
                
                return
            }
            
        default:
            fatalError()
        }
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
        partTimeView.historyTable.reloadData()
    }
    @objc private func changeDeduction(_ sender: UIButton) {
        
        taxIndex += 1
        partTimeView.setButtonTitle(title: tax[taxIndex % tax.count])
        
        loadPartTimeValue(deduction: taxIndex % tax.count)
    }
    @objc private func returnSaveView(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            let division = saveView.titleLabel
            
            let date = Int(saveView.dateTextField.text ?? "") ?? 0
            let weekDay = model.getWeekDay(year: yearInt, month: monthInt, day: date)
            let working = Int(saveView.workingTextField.text ?? "") ?? 0
            let workingMin = Int(saveView.workingMinTextField.text ?? "") ?? 0
            let over = Int(saveView.overTextField.text ?? "") ?? 0
            let overMin = Int(saveView.overMinTextField.text ?? "") ?? 0
            let night = Int(saveView.nightTextField.text ?? "") ?? 0
            let nightMin = Int(saveView.nightMinTextField.text ?? "") ?? 0
            let overNight = Int(saveView.overNightTextField.text ?? "") ?? 0
            let overNightMin = Int(saveView.overNightMinTextField.text ?? "") ?? 0
            let hourly = Int(saveView.hourlyWageTextField.text ?? "") ?? 0

            let totalTime = model.totalWorkCalcu(working: working,
                                                 workingMin: workingMin,
                                                 over: over,
                                                 overMin: overMin,
                                                 night: night,
                                                 nightMin: nightMin,
                                                 overNight: overNight,
                                                 overNightMin: overNightMin)
            
            let totalPay = model.totalPaySum(working: Double(working),
                                             workingMin: Double(workingMin),
                                             hourly: Double(hourly),
                                             over: Double(over),
                                             overMin: Double(overMin),
                                             night: Double(night),
                                             nightMin: Double(nightMin),
                                             overNight: Double(overNight),
                                             overNightMin: Double(overNightMin))
            
            let value = PayList.Year.Month.Data(date: date,
                                                weekDay: weekDay,
                                                workingTime: working,
                                                workingTimeMin: workingMin,
                                                overTime: over,
                                                overTimeMin: overMin,
                                                nightTime: night,
                                                nightTimeMin: nightMin,
                                                overNightTime: overNight,
                                                overNightTimeMin: overNightMin,
                                                hourlyWage: hourly,
                                                totalTime: totalTime,
                                                totalPay: totalPay)
            
            data = model.editData(division: division.text ?? "", data: &data, yearIndex: yearIndex, monthIndex: monthIndex, index: division.tag, value: value)
            model.saveData(data: data ?? PayList(years: [PayList.Year]()))
            loadPartTimeValue(deduction: taxIndex % tax.count)
            partTimeView.historyTable.reloadData()
            
        }
        
        [saveView.dateTextField, saveView.hourlyWageTextField, saveView.workingTextField, saveView.workingMinTextField,
         saveView.overTextField, saveView.overMinTextField, saveView.nightTextField, saveView.nightMinTextField,
         saveView.overNightTextField, saveView.overNightMinTextField].forEach { (textField) in
            
            textField.resignFirstResponder()
        }
        moveSaveView(offset: 0)
    }
    @objc private func textCountLimit(_ sender: UITextField) {
        
        switch sender {
        case saveView.dateTextField:
            
            sender.text?.count == 0 ? setLabelAlpha(label: saveView.dayLabel, value: 0) : setLabelAlpha(label: saveView.dayLabel, value: 1)
        case saveView.workingTextField, saveView.workingMinTextField:
            
            sender.text?.count == 0 ? setLabelAlpha(label: saveView.workLabel, value: 0) : setLabelAlpha(label: saveView.workLabel, value: 1)
        case saveView.overTextField, saveView.overMinTextField:
            
            sender.text?.count == 0 ? setLabelAlpha(label: saveView.overWorkLabel, value: 0) : setLabelAlpha(label: saveView.overWorkLabel, value: 1)
        case saveView.nightTextField, saveView.nightMinTextField:
            
            sender.text?.count == 0 ? setLabelAlpha(label: saveView.nightWorkLabel, value: 0) : setLabelAlpha(label: saveView.nightWorkLabel, value: 1)
        case saveView.overNightTextField, saveView.overNightMinTextField:
            
            sender.text?.count == 0 ? setLabelAlpha(label: saveView.overNightWorkLabel, value: 0) : setLabelAlpha(label: saveView.overNightWorkLabel, value: 1)
        default:
            
            fatalError()
        }
        
        guard sender.text?.count ?? 0 < 3  else { return sender.deleteBackward() }
    }
}

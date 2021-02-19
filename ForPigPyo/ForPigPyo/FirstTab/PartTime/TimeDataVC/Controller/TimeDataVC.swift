//
//  TimeDataVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/18.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class TimeDataVC: UIViewController {
    
    let timeDataView: TimeDataView = {
        let view = TimeDataView()
        
        return view
    }()
    
    private let model = TimeDataVCModel()
    
    private var hourly: Int = 0
    
    private var work: Int = 0
    private var workMin: Int = 0
    
    private var over: Int = 0
    private var overMin: Int = 0
    
    private var night: Int = 0
    private var nightMin: Int = 0
    
    private var overNight: Int = 0
    private var overNightMin: Int = 0
    
    private var totalTime: [Int] = [0, 0]
    private var totalPay: Int = 0
    
    var data: PayList?
    var yearIndex: Int = 0
    var monthIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setView()
    }
    
    private func setView() {
        
        view.backgroundColor = .systemBackground
        
        timeDataView.allContainerView.forEach {
            $0.textFieldBundle.forEach { (textField) in
                textField.addTarget(self, action: #selector(textCountLimit(_:)), for: .editingChanged)
            }
        }
        
        timeDataView.dismissButton.addTarget(self, action: #selector(xButton(_:)), for: .touchUpInside)
        timeDataView.saveButton.addTarget(self, action: #selector(dataSave(_:)), for: .touchUpInside)
        view.addSubview(timeDataView)
        
        timeDataView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func reloadValue() {
        
        hourly = Int(timeDataView.hourlyWageView.textField1.text ?? "") ?? 0
        
        work = Int(timeDataView.workView.textField1.text ?? "") ?? 0
        workMin = Int(timeDataView.workView.textField2.text ?? "") ?? 0
        
        over = Int(timeDataView.overView.textField1.text ?? "") ?? 0
        overMin = Int(timeDataView.overView.textField2.text ?? "") ?? 0
        
        night = Int(timeDataView.nightView.textField1.text ?? "") ?? 0
        nightMin = Int(timeDataView.nightView.textField2.text ?? "") ?? 0
        
        overNight = Int(timeDataView.overNightView.textField1.text ?? "") ?? 0
        overNightMin = Int(timeDataView.overNightView.textField2.text ?? "") ?? 0
    }
    func totalCalcu() {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        reloadValue()
        
        totalTime = model.totalWorkCalcu(work: work,
                                         workMin: workMin,
                                         over: over,
                                         overMin: overMin,
                                         night: night,
                                         nightMin: nightMin,
                                         overNight: overNight,
                                         overNightMin: overNightMin)
        
        timeDataView.totalView.label2.text = "\(totalTime[0]) 시간"
        timeDataView.totalView.label3.text = "\(totalTime[1]) 분"
        
        totalPay = model.totalPaySum(hourly: Double(hourly),
                                     working: Double(work),
                                     workingMin: Double(workMin),
                                     over: Double(over),
                                     overMin: Double(overMin),
                                     night: Double(night),
                                     nightMin: Double(nightMin),
                                     overNight: Double(overNight),
                                     overNightMin: Double(overNightMin))
        
        timeDataView.previewLabel.text = "\(formatter.string(from: totalPay as NSNumber) ?? "0") 원"
    }
    
    @objc private func xButton(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    @objc private func keyboardNotification(_ sender: NSNotification) {
        
        switch sender.name {
        case UIResponder.keyboardDidShowNotification:
            
            if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                timeDataView.constraint?.update(inset: 55 + keyboardSize.height)
            }
        case UIResponder.keyboardWillHideNotification:
            
            UIView.animate(withDuration: 0.5) {
                
                self.timeDataView.constraint?.update(inset: 55)
                self.view.layoutIfNeeded()
            }
        default:
            fatalError()
        }
    }
    @objc private func dataSave(_ sender: UIButton) {
        
        let division = timeDataView.titleLabel
        
        let date = Int(timeDataView.dateView.textField1.text ?? "") ?? 0
        let weekDay = model.getWeekDay(year: timeDataView.dateView.label1.tag,
                                       month: timeDataView.dateView.label2.tag,
                                       day: date)
        
        reloadValue()
        
        let value = PayList.Year.Month.Data(date: date,
                                            weekDay: weekDay,
                                            workingTime: work,
                                            workingTimeMin: workMin,
                                            overTime: over,
                                            overTimeMin: overMin,
                                            nightTime: night,
                                            nightTimeMin: nightMin,
                                            overNightTime: overNight,
                                            overNightTimeMin: overNightMin,
                                            hourlyWage: hourly,
                                            totalTime: "\(totalTime[0])시간 \(totalTime[1])분",
                                            totalPay: totalPay)
        
        data = model.editData(division: division.text ?? "",
                              data: &data,
                              yearIndex: yearIndex,
                              monthIndex: monthIndex,
                              saveIndex: division.tag,
                              value: value)
        
        if let mainTabVC = presentingViewController as? MainTabVC {
            if let partTimeVC = mainTabVC.children[0].children[1] as? PartTimeVC {
                
                partTimeVC.data = data
                partTimeVC.model.saveData(data: data ?? PayList(years: [PayList.Year]()))
                partTimeVC.loadPartTimeValue(deduction: partTimeVC.taxIndex % partTimeVC.tax.count)
                partTimeVC.partTimeView.emptyView.isHidden = true
                partTimeVC.partTimeView.historyTable.reloadData()
            }
        }
        
        dismiss(animated: true)
    }
    @objc private func textCountLimit(_ sender: UITextField) {
        
        guard sender.text?.count ?? 0 < 3 || sender == timeDataView.hourlyWageView.textField1 else { return sender.deleteBackward() }
        
        totalCalcu()
    }
}

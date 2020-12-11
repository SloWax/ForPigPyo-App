//
//  PartTimeSaveView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/13.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class PartTimeSaveView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.textAlignment = .center
        label.font = Design.boldLargeTextSize
        label.text = "title"
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜 :"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let dateTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "날짜", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let hourlyWageLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let hourlyWageTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "시급", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let workingLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let workLabel: UILabel = {
        let label = UILabel()
        label.text = "근무 :"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        label.alpha = 0
        
        return label
    }()
    let workingTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "근무", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    let workingMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let workingMinTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "근무", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let overLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let overWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "특근 :"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        label.alpha = 0
        
        return label
    }()
    let overTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "특근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    let overMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let overMinTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "특근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let nightLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let nightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야근 :"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        label.alpha = 0
        
        return label
    }()
    let nightTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "야근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    let nightMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let nightMinTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "야근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let overNightLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let overNightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야/특근 :"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        label.alpha = 0
        
        return label
    }()
    let overNightTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "야/특근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    let overNightMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = Design.textBasic
        label.textAlignment = .left
        label.font = Design.nomalTextSize
        
        return label
    }()
    let overNightMinTextField: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.nomalTextSize]
        textField.attributedPlaceholder = NSAttributedString(string: "야/특근", attributes: attributes as [NSAttributedString.Key : Any])
        textField.font = Design.nomalTextSize
        textField.textAlignment = .right
        textField.textColor = Design.textBasic
        textField.keyboardType = .numberPad
        textField.doneAccessory = true
        
        return textField
    }()
    
    let cancleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.tintColor = Design.purple
        button.backgroundColor = Design.textBasic
        button.tag = 0
        
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.tintColor = Design.purple
        button.backgroundColor = Design.textBasic
        button.tag = 1
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        
        setTitleLabel()
        
        setDate()
        setHourlyWage()
        
        setTotal()
        setOver()
        setNight()
        setOverNight()
        
        setButton()
    }
    private func setView() {
        
        self.layer.cornerRadius = Design.cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = Design.textBasic.cgColor
        self.backgroundColor = Design.purple
    }
    private func setTitleLabel() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Design.LargePadding)
        }
    }
    private func setDate() {
        
        self.addSubview(dateLabel)
        self.addSubview(dayLabel)
        self.addSubview(dateTextField)
        
        dateLabel.snp.makeConstraints {

            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.nomalPadding)
            $0.width.equalTo(self.snp.width).multipliedBy(0.06)
            $0.trailing.equalTo(self.snp.centerX)
        }
        dayLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel)
            $0.leading.equalTo(titleLabel)
        }
        dateTextField.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel)
            $0.leading.equalTo(dayLabel.snp.trailing)
            $0.trailing.equalTo(dateLabel.snp.leading).offset(-Design.smallPadding)
        }
    }
    private func setHourlyWage() {
        
        self.addSubview(hourlyWageLabel)
        self.addSubview(hourlyWageTextField)
        
        hourlyWageLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel)
            $0.width.equalTo(self.snp.width).multipliedBy(0.06)
            $0.trailing.equalTo(titleLabel)
        }
        hourlyWageTextField.snp.makeConstraints {
            
            $0.top.equalTo(hourlyWageLabel)
            $0.leading.equalTo(self.snp.centerX)
            $0.trailing.equalTo(hourlyWageLabel.snp.leading).offset(-Design.smallPadding)
        }
    }
    private func setTotal() {
        
        self.addSubview(workingLabel)
        self.addSubview(workLabel)
        self.addSubview(workingTextField)
        
        workingLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom).offset(Design.nomalPadding)
            $0.width.equalTo(self.snp.width).multipliedBy(0.1)
            $0.trailing.equalTo(dateLabel)
        }
        workLabel.snp.makeConstraints {
            
            $0.top.equalTo(workingLabel)
            $0.leading.equalTo(dayLabel)
        }
        workingTextField.snp.makeConstraints {
            
            $0.top.equalTo(workingLabel)
            $0.leading.equalTo(dateTextField)
            $0.trailing.equalTo(workingLabel.snp.leading).offset(-Design.smallPadding)
        }
        
        self.addSubview(workingMinLabel)
        self.addSubview(workingMinTextField)
        
        workingMinLabel.snp.makeConstraints {
            $0.top.equalTo(workingLabel)
            $0.leading.trailing.equalTo(hourlyWageLabel)
        }
        workingMinTextField.snp.makeConstraints {
            
            $0.top.equalTo(workingTextField)
            $0.leading.trailing.equalTo(hourlyWageTextField)
        }
    }
    private func setOver() {
        
        self.addSubview(overLabel)
        self.addSubview(overWorkLabel)
        self.addSubview(overTextField)
        
        overLabel.snp.makeConstraints {
            
            $0.top.equalTo(workingLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalTo(workingLabel)
        }
        overWorkLabel.snp.makeConstraints {
            
            $0.top.equalTo(overLabel)
            $0.leading.equalTo(workLabel)
        }
        overTextField.snp.makeConstraints {
            
            $0.top.equalTo(overLabel)
            $0.leading.trailing.equalTo(workingTextField)
        }
        
        self.addSubview(overMinLabel)
        self.addSubview(overMinTextField)
        
        overMinLabel.snp.makeConstraints {
            $0.top.equalTo(overLabel)
            $0.leading.trailing.equalTo(workingMinLabel)
        }
        overMinTextField.snp.makeConstraints {
            $0.top.equalTo(overMinLabel)
            $0.leading.trailing.equalTo(workingMinTextField)
        }
    }
    private func setNight() {
        
        self.addSubview(nightLabel)
        self.addSubview(nightWorkLabel)
        self.addSubview(nightTextField)
        
        nightLabel.snp.makeConstraints {
            
            $0.top.equalTo(overLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalTo(overLabel)
        }
        nightWorkLabel.snp.makeConstraints {
            
            $0.top.equalTo(nightLabel)
            $0.leading.equalTo(overWorkLabel)
        }
        nightTextField.snp.makeConstraints {
            
            $0.top.equalTo(nightLabel)
            $0.leading.trailing.equalTo(overTextField)
        }
        
        self.addSubview(nightMinLabel)
        self.addSubview(nightMinTextField)
        
        nightMinLabel.snp.makeConstraints {
            
            $0.top.equalTo(nightLabel)
            $0.leading.trailing.equalTo(overMinLabel)
        }
        nightMinTextField.snp.makeConstraints {
            
            $0.top.equalTo(nightMinLabel)
            $0.leading.trailing.equalTo(overMinTextField)
        }
    }
    private func setOverNight() {
        
        self.addSubview(overNightLabel)
        self.addSubview(overNightWorkLabel)
        self.addSubview(overNightTextField)
        
        overNightLabel.snp.makeConstraints {
            $0.top.equalTo(nightLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalTo(nightLabel)
        }
        overNightWorkLabel.snp.makeConstraints {
            
            $0.top.equalTo(overNightLabel)
            $0.leading.equalTo(nightWorkLabel)
        }
        overNightTextField.snp.makeConstraints {
            
            $0.top.equalTo(overNightLabel)
            $0.leading.trailing.equalTo(nightTextField)
        }
        
        self.addSubview(overNightMinLabel)
        self.addSubview(overNightMinTextField)
        
        overNightMinLabel.snp.makeConstraints {
            
            $0.top.equalTo(overNightLabel)
            $0.leading.trailing.equalTo(nightMinLabel)
        }
        overNightMinTextField.snp.makeConstraints {
            
            $0.top.equalTo(overNightMinLabel)
            $0.leading.trailing.equalTo(nightMinTextField)
        }
    }
    private func setButton() {
        
        self.addSubview(cancleButton)
        self.addSubview(saveButton)
        
        cancleButton.snp.makeConstraints {
            
            $0.top.equalTo(overNightLabel.snp.bottom).offset(Design.LargePadding)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(self.snp.centerX).offset(-Design.LargePadding / 2)
            
            $0.bottom.equalToSuperview().inset(Design.LargePadding)
        }
        saveButton.snp.makeConstraints {
            
            $0.top.equalTo(cancleButton)
            $0.leading.equalTo(self.snp.centerX).offset(Design.LargePadding / 2)
            $0.trailing.equalTo(titleLabel)
        }
    }
    
    func setValue(title: String, date: String?, hourly: String?, index: Int, value: PayList.Year.Month.Data?) {
        
        titleLabel.text = title
        
        if let value = value {
            
            titleLabel.tag = index
            
            dateTextField.text = "\(value.date)"
            hourlyWageTextField.text = "\(value.hourlyWage)"

            workingTextField.text = "\(value.workingTime)"
            workingMinTextField.text = "\(value.workingTimeMin)"
            
            overTextField.text = "\(value.overTime)"
            overMinTextField.text = "\(value.overTimeMin)"
            
            nightTextField.text = "\(value.nightTime)"
            nightMinTextField.text = "\(value.nightTimeMin)"
            
            overNightTextField.text = "\(value.overNightTime)"
            overNightMinTextField.text = "\(value.overNightTimeMin)"
            
            [dayLabel, workLabel, overWorkLabel, nightWorkLabel, overNightWorkLabel].forEach { (label) in

                label.alpha = 1
            }
            
            return
        }
        
        dateTextField.text = date
        hourlyWageTextField.text = hourly
        
        
        [ workingTextField, workingMinTextField, overTextField, overMinTextField, nightTextField, nightMinTextField, overNightTextField, overNightMinTextField].forEach { (textField) in
            
            textField.text = nil
        }
        [workLabel, overWorkLabel, nightWorkLabel, overNightWorkLabel].forEach { (label) in

            label.alpha = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

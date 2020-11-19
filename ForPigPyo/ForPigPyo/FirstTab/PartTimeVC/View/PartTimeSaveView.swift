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
        label.textColor = .white
        label.textAlignment = .center
        label.font = Design.boldLargeTextSize
        label.text = "title"
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜 :"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "날짜", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let hourlyWageLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let hourlyWageTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "시급", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let workLabel: UILabel = {
        let label = UILabel()
        label.text = "근무 :"
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    let totalTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "근무", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    let totalMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let totalMinTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "근무", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let overLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let overWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "특근 :"
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    let overTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "특근", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    let overMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let overMinTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "특근", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let nightLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let nightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야간 근무 :"
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    let nightTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "야간 근무", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    let nightMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let nightMinTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "야간 근무", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let overNightLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let overNightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야간 특근 :"
        label.textColor = .white
        label.textAlignment = .left
        label.alpha = 0
        
        return label
    }()
    let overNightTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "야간 특근", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    let overNightMinLabel: UILabel = {
        let label = UILabel()
        label.text = "분"
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    let overNightMinTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "야간 특근", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let cancleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.tintColor = .systemPurple
        button.backgroundColor = .white
        button.tag = 0
        
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.tintColor = .systemPurple
        button.backgroundColor = .white
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
        
        setCancleButton()
        setSaveButton()
    }
    private func setView() {
        
        self.layer.cornerRadius = Design.cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .systemPurple
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
        
        self.addSubview(totalLabel)
        self.addSubview(workLabel)
        self.addSubview(totalTextField)
        
        totalLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom).offset(Design.nomalPadding)
            $0.width.equalTo(self.snp.width).multipliedBy(0.1)
            $0.trailing.equalTo(dateLabel)
        }
        workLabel.snp.makeConstraints {
            
            $0.top.equalTo(totalLabel)
            $0.leading.equalTo(dayLabel)
        }
        totalTextField.snp.makeConstraints {
            
            $0.top.equalTo(totalLabel)
            $0.leading.equalTo(dateTextField)
            $0.trailing.equalTo(totalLabel.snp.leading).offset(-Design.smallPadding)
        }
        
        self.addSubview(totalMinLabel)
        self.addSubview(totalMinTextField)
        
        totalMinLabel.snp.makeConstraints {
            $0.top.equalTo(totalLabel)
            $0.leading.trailing.equalTo(hourlyWageLabel)
        }
        totalMinTextField.snp.makeConstraints {
            
            $0.top.equalTo(totalTextField)
            $0.leading.trailing.equalTo(hourlyWageTextField)
        }
    }
    private func setOver() {
        
        self.addSubview(overLabel)
        self.addSubview(overWorkLabel)
        self.addSubview(overTextField)
        
        overLabel.snp.makeConstraints {
            
            $0.top.equalTo(totalLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalTo(totalLabel)
        }
        overWorkLabel.snp.makeConstraints {
            
            $0.top.equalTo(overLabel)
            $0.leading.equalTo(workLabel)
        }
        overTextField.snp.makeConstraints {
            
            $0.top.equalTo(overLabel)
            $0.leading.trailing.equalTo(totalTextField)
        }
        
        self.addSubview(overMinLabel)
        self.addSubview(overMinTextField)
        
        overMinLabel.snp.makeConstraints {
            $0.top.equalTo(overLabel)
            $0.leading.trailing.equalTo(totalMinLabel)
        }
        overMinTextField.snp.makeConstraints {
            $0.top.equalTo(overMinLabel)
            $0.leading.trailing.equalTo(totalMinTextField)
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
    private func setCancleButton() {
        
        self.addSubview(cancleButton)
        
        cancleButton.snp.makeConstraints {
            
            $0.top.equalTo(overNightLabel.snp.bottom).offset(Design.LargePadding)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(self.snp.centerX).offset(-Design.LargePadding / 2)
            
            $0.bottom.equalToSuperview().inset(Design.LargePadding)
        }
    }
    private func setSaveButton() {
        
        self.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            
            $0.top.equalTo(cancleButton)
            $0.leading.equalTo(self.snp.centerX).offset(Design.LargePadding / 2)
            $0.trailing.equalTo(titleLabel)
        }
    }
    func setValue(title: String, date: String?, index: Int, value: PayList.Years.Month.Data?) {
        
        titleLabel.text = title
        
        if let value = value {
            
            titleLabel.tag = index
            
            dateTextField.text = "\(value.date)"
            hourlyWageTextField.text = "\(value.hourlyWage)"

            totalTextField.text = "\(value.workingTime)"
            totalMinTextField.text = "\(value.workingTimeMin)"
            
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
        
        [hourlyWageTextField, totalTextField, overTextField, nightTextField, overNightTextField].forEach { (textField) in
            
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

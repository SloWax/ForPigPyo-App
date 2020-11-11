//
//  PartTimeSaveView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/13.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class PartTimeSaveView: UIView {
    
    let cancleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.tintColor = .white
        
        return button
    }()
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "날짜", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    let hourlyWageTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "시급", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        
        return textField
    }()
    
    let totalTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        
        return textField
    }()
    let overTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        
        return textField
    }()
    let nightTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        
        return textField
    }()
    let overNightTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.textColor = .white
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        
        setCancleButton()
        setSaveButton()
        
        setDateTextField()
        setHourlyWageTextField()
        
        
    }
    private func setView() {
        
        self.layer.cornerRadius = Design.cornerRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .systemPurple
    }
    private func setCancleButton() {
        
        self.addSubview(cancleButton)
        
        cancleButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    private func setSaveButton() {
        
        self.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    private func setDateTextField() {
        
        self.addSubview(dateTextField)
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(cancleButton.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX)
        }
    }
    private func setHourlyWageTextField() {
        
        self.addSubview(hourlyWageTextField)
        
        hourlyWageTextField.snp.makeConstraints {
            $0.top.equalTo(dateTextField)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(self.snp.centerX)
            
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

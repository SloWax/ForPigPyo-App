//
//  PunchInContainerButton.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/04.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class PunchInContainerButton: UIButton {
    
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
    }
    
    private let lblCenterValue = UILabel().then {
        $0.textColor = .setCustomColor(.gray6)
        $0.textAlignment = .right
    }
    
    private let lblCenterUnit = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
    }
    
    private let lblRightValue = UILabel().then {
        $0.textColor = .setCustomColor(.gray6)
        $0.textAlignment = .right
    }
    
    private let lblRightUnit = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .setCustomColor(.lightGray)
//        self.layer.cornerRadius = Design.cornerRadius
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [
            lblTitle,
            lblCenterValue, lblCenterUnit,
            lblRightValue, lblRightUnit
        ]
        
        views.forEach {
            $0.font = .setCustomFont(font: .bold, size: 20)
            $0.isUserInteractionEnabled = false
        }
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).inset(15)
        }
        
        lblCenterUnit.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.right).multipliedBy(0.37)
        }
        
        lblCenterValue.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(lblCenterUnit.snp.left).offset(-5)
        }
        
        lblRightUnit.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.right).multipliedBy(0.74)
        }
        
        lblRightValue.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(lblRightUnit.snp.left).offset(-5)
        }
    }
    
    func setDefault(title: String, centerValue: String? = nil, centerUnit: String? = nil, rightValue: String? = nil, rightUnit: String? = nil) {
        lblTitle.text = title
        
        lblCenterValue.text = centerValue
        lblCenterUnit.text = centerUnit
        
        lblRightValue.text = rightValue
        lblRightUnit.text = rightUnit
    }
}

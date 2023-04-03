//
//  TimeCardStatusView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/03.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class TimeCardStatusView: UIView {
    
    private let lblTitle = UILabel().then {
        $0.attributedText = "이번 달에는 얼마를 받을까요?".underLine
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 14)
    }
    
    private let lblValue = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
        
    let btnTax = UIButton(type: .system).then {
        $0.tintColor = .setCustomColor(.textBasic)
        $0.titleLabel?.font = .setCustomFont(font: .bold, size: 14)
        $0.backgroundColor = .setCustomColor(.gray1)
        $0.layer.cornerRadius = 15
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .setCustomColor(.lightGray)
        self.layer.cornerRadius = 15
        
        let views = [lblTitle, lblValue, btnTax]
        self.addSubviews(views)
        
        lblTitle.snp.makeConstraints {
            $0.top.left.equalTo(self).offset(15)
        }
        
        btnTax.snp.makeConstraints {
            $0.centerY.equalTo(lblTitle)
            $0.right.equalTo(self).inset(15)
            $0.width.equalTo(self).multipliedBy(0.15)
            $0.height.equalTo(btnTax.snp.width).multipliedBy(0.37)
        }
        
        lblValue.snp.makeConstraints {
            $0.top.equalTo(lblTitle.snp.bottom).offset(5)
            $0.right.equalTo(btnTax)
            $0.bottom.equalTo(self).inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValue(wage: Int, tax: String) {
        lblValue.text = "총 급여: \(wage.comma)".won
        btnTax.setTitle(tax, for: .normal)
    }
}

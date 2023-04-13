//
//  MyPageView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/23.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import Then
import SnapKit


class MyPageView: BaseView {
    
    private let lblTitle = UILabel().then {
        $0.attributedText = "내 정보".underLine
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
    
    private let svButtons = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    let btnWage = PyoMyMenuButton().then {
        $0.setValue(image: "hourly", title: "나의 시급 설정")
    }
    
    let btnHour = PyoMyMenuButton().then {
        $0.setValue(image: "worktime", title: "근무 시간 설정")
    }
    
    let btnTax = PyoMyMenuButton().then {
        $0.setValue(image: "tax", title: "기본 세금 설정")
    }
    
    let btnBackup = PyoMyMenuButton().then {
        $0.setValue(image: "icloud", title: "데이터 백업")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let arrangedSubviews = [btnWage, btnHour, btnTax, btnBackup]
        svButtons.addArrangedSubviews(arrangedSubviews)
        
        let views = [lblTitle, svButtons]
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).multipliedBy(0.1)
            $0.left.equalTo(self).inset(15)
        }
        
        svButtons.snp.makeConstraints {
            $0.top.equalTo(lblTitle.snp.bottom).offset(10)
            $0.left.right.equalTo(self).inset(15)
        }
    }
}


final class PyoMyMenuButton: UIButton {
    
    private let ivImage = UIImageView().then {
        $0.tintColor = .setCustomColor(.gray10)
    }
    
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.gray10)
        $0.font = .setCustomFont(font: .bold, size: 18)
    }
    
    private let lblValue = UILabel().then {
        $0.text = "미설정"
        $0.textColor = .setCustomColor(.gray10)
        $0.font = .setCustomFont(font: .bold, size: 20)
        $0.textAlignment = .right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        self.backgroundColor = .setCustomColor(.gray1)
        
        let views = [ivImage, lblTitle, lblValue]
        self.addSubviews(views)
    }
    
    private func setLayout() {
        ivImage.snp.makeConstraints {
            $0.top.left.bottom.equalTo(self).inset(15)
            $0.width.equalTo(self.snp.width).multipliedBy(0.14)
            $0.height.equalTo(ivImage.snp.width)
        }
        
        lblTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
        lblTitle.snp.makeConstraints {
            $0.left.equalTo(ivImage.snp.right).offset(15)
            $0.centerY.equalTo(ivImage.snp.centerY)
        }
        
        lblValue.snp.makeConstraints {
            $0.left.equalTo(lblTitle.snp.right).offset(5)
            $0.right.equalTo(self).inset(15)
            $0.centerY.equalTo(self)
        }
    }
    
    func setValue(image: String? = nil, title: String? = nil, value: String? = nil) {
        
        if let image = image { ivImage.image = UIImage(named: image) }
        
        if let title = title { lblTitle.attributedText = title.underLine }
        
        if let value = value { lblValue.text = value }
    }
}

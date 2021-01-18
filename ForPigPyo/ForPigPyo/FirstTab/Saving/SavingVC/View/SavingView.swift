//
//  SavingView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        
        return label
    }()
    let setAimButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Design.lightGray
        
        button.setTitle("목표 설정", for: .normal)
        button.titleLabel?.font = Design.boldSmallTextSize
        button.tintColor = Design.textBasic
        
        button.layer.cornerRadius = Design.cornerRadius
        button.layer.borderColor = Design.yellow.cgColor
        button.layer.borderWidth = 2
        
        return button
    }()
    
    let myAimView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "나의 목표 금액"
        
        view.label2.text = "0 원"
        
        return view
    }()
    let untilAimView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "지금까지 얼마나 모았을까요?"
        
        view.label2.text = "0 원"
        
        return view
    }()
    let untilDateView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "목표까지 남은 기간"
        
        view.label2.text = "Day"
        
        return view
    }()
    let thisMonthView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "이번 달 모은 금액"
        
        view.label2.text = "0 원"
        
        return view
    }()
    private lazy var allContainerView = [myAimView, untilAimView, untilDateView, thisMonthView]
    
    let savingAdminButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Design.yellow
        
        button.setTitle("저축액 관리하기", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.tintColor = .systemBackground
        
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setLabel()
    }
    
    private func setView() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(setAimButton)
        
        setAimButton.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.width.equalToSuperview().multipliedBy(0.19)
            $0.height.equalTo(setAimButton.snp.width).multipliedBy(0.57)
        }
        
        allContainerView.forEach { self.addSubview($0) }
        
        myAimView.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        untilAimView.snp.makeConstraints {
            
            $0.top.equalTo(myAimView.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        untilDateView.snp.makeConstraints {
            
            $0.top.equalTo(untilAimView.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        thisMonthView.snp.makeConstraints {
            
            $0.top.equalTo(untilDateView.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(savingAdminButton)
        
        savingAdminButton.snp.makeConstraints {
            
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview().inset(Design.padding)
            $0.width.equalToSuperview().multipliedBy(0.39)
            $0.height.equalTo(savingAdminButton.snp.width).multipliedBy(0.34)
        }
    }
    private func setLabel() {
        
        allContainerView.forEach { (containerView) in
            
            containerView.label1.font = Design.boldSmallTextSize
            
            containerView.label1.snp.makeConstraints {
                $0.top.equalToSuperview().offset(Design.nomalPadding)
                $0.leading.equalToSuperview().inset(Design.largestPadding)
            }
            
            containerView.label2.font = Design.boldNomalTextSize
            
            containerView.label2.snp.makeConstraints {
                
                $0.top.equalTo(containerView.label1.snp.bottom)
                $0.trailing.equalToSuperview().inset(Design.largestPadding)
                $0.bottom.equalToSuperview().inset(Design.nomalPadding)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

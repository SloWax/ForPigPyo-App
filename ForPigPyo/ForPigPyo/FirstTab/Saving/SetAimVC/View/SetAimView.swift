//
//  SetAimView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SetAimView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        label.attributedText = "목표 설정하기".underLine
        
        return label
    }()
    
    let myAimView: ContainerView = {
        let view = ContainerView()
        let attributes = [NSAttributedString.Key.foregroundColor : Design.textBasic.withAlphaComponent(0.5), .font: Design.boldNomalTextSize]
        view.label1.text = "목표 금액:"
        view.label2.text = "원"
        
        view.textField1.attributedPlaceholder = NSAttributedString(string: "목표 금액", attributes: attributes as [NSAttributedString.Key : Any])
        
        return view
    }()
    let untilDateView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "목표일:"
        view.label2.text = "년"
        view.label3.text = "월"
        view.label4.text = "일"
        
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Design.yellow
        
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.tintColor = .systemBackground
        
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setObject()
    }
    
    private func setView() {
        
        self.backgroundColor = .systemBackground
        
        self.addSubview(myAimView)
        
        myAimView.snp.makeConstraints {
            
            $0.bottom.equalTo(self.snp.centerY).offset(-Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.height.equalTo(myAimView.snp.width).multipliedBy(0.175)
        }
        
        self.addSubview(untilDateView)
        
        untilDateView.snp.makeConstraints {
            
            $0.top.equalTo(self.snp.centerY).inset(Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.height.equalTo(myAimView)
        }
        
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.leading.equalTo(myAimView)
            $0.bottom.equalTo(myAimView.snp.top).offset(-Design.largestPadding)
        }
        
        self.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            
            $0.top.equalTo(untilDateView.snp.bottom).offset(Design.largePadding)
            $0.trailing.equalTo(untilDateView).inset(Design.nomalPadding)
            $0.width.equalToSuperview().multipliedBy(0.16)
            $0.height.equalTo(saveButton.snp.width)
        }
    }
    private func setObject() {
        
        [myAimView, untilDateView].forEach { (containerView) in
            
            containerView.labelBundle.forEach {
                
                $0.font = Design.boldNomalTextSize
                
                $0.snp.makeConstraints {
                    
                    $0.centerY.equalToSuperview()
                }
            }
            
            containerView.label1.snp.makeConstraints {
                
                $0.leading.equalToSuperview().inset(Design.largePadding)
            }
        }
        
        myAimView.label2.snp.makeConstraints {
            
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
        }
        
        myAimView.textField1.snp.makeConstraints {
            
            $0.centerY.equalTo(myAimView.label2)
            $0.trailing.equalTo(myAimView.label2.snp.leading).offset(-Design.smallPadding)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        untilDateView.buttonBundle.forEach {
            
            $0.titleLabel?.font = Design.boldNomalTextSize
            
            $0.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
            }
        }
        
        untilDateView.label4.snp.makeConstraints {
            
            $0.trailing.equalTo(myAimView.label2)
        }
        
        untilDateView.button3.snp.makeConstraints {
            
            $0.trailing.equalTo(untilDateView.label4.snp.leading)
        }
        
        untilDateView.label3.snp.makeConstraints {

            $0.trailing.equalTo(untilDateView.button3.snp.leading)
        }
        
        untilDateView.button2.snp.makeConstraints {
            
            $0.trailing.equalTo(untilDateView.label3.snp.leading)
        }

        untilDateView.label2.snp.makeConstraints {

            $0.trailing.equalTo(untilDateView.button2.snp.leading)
        }
        
        untilDateView.button1.snp.makeConstraints {
            
            $0.trailing.equalTo(untilDateView.label2.snp.leading)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

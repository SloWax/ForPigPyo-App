//
//  EmailView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// EmailVC 전체 View

class EmailView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        
        return label
    }()
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.layer.cornerRadius = Design.cornerRadius
        
        view.label1.font = Design.boldNomalTextSize
        view.label1.numberOfLines = 0
        view.label1.text = """
원하는 기능을 메일에 적어서 보내주세요. 짬짬이 개발해 추가하겠습니다!
"""
        let attrString = NSMutableAttributedString(string: view.label1.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        view.label1.attributedText = attrString
        
        view.label2.font = Design.boldNomalTextSize
        view.label2.text = "- 모두의 개발진"
        
        return view
    }()
    
    let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setTitle("email 보내기", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.backgroundColor = Design.yellow
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.padding)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.label1.snp.makeConstraints {
            
            $0.top.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.label2.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label1.snp.bottom).offset(140)
            $0.trailing.bottom.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(emailButton)
        
        emailButton.snp.makeConstraints {
            
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview().inset(Design.padding)
            $0.width.equalToSuperview().multipliedBy(0.39)
            $0.height.equalTo(emailButton.snp.width).multipliedBy(0.34)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

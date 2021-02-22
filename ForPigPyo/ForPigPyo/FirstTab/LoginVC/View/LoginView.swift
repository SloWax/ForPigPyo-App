//
//  LoginView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        label.attributedText = "로그인".underLine
        
        return label
    }()
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.layer.cornerRadius = Design.cornerRadius
        
        view.label1.font = Design.boldNomalTextSize
        view.label1.numberOfLines = 0
        view.label1.text = """
안전한 데이터 저장을 위해 계정을 등록해주세요!
"""
        let attrString = NSMutableAttributedString(string: view.label1.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        view.label1.attributedText = attrString
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.backgroundColor = .systemBackground
        
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
            
            $0.top.leading.trailing.bottom.equalToSuperview().inset(Design.largePadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

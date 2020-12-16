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
    
    private let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldNomalTextSize
        label.layer.cornerRadius = Design.cornerRadius
        label.layer.borderColor = Design.textBasic.cgColor
        label.numberOfLines = 0
        label.text = """
원하는 기능을 메일에 적어서 보내주세요.
언제가 될지는 모르겠지만 짬짬이 개발해 추가해드리겠습니다!

메일을 보내주신 뒤
잠시 시간을 내어주시어 광고를 봐주신다면 개발이 더욱 빨라질 수 있습니다!!
"""
        let attrString = NSMutableAttributedString(string: label.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .center
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        
        return label
    }()
    let emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("email 보내기", for: .normal)
        button.titleLabel?.font = Design.boldLargeTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.backgroundColor = Design.textBasic
        button.tintColor = Design.purple
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setExplainLabel()
        setEmailButton()
    }
    
    private func setExplainLabel() {
        
        self.addSubview(explainLabel)
        
        explainLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Design.LargePadding)
        }
    }
    private func setEmailButton() {
        
        self.addSubview(emailButton)
        
        emailButton.snp.makeConstraints {
            $0.top.equalTo(explainLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.equalToSuperview().inset(Design.nomalPadding)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

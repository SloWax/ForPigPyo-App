//
//  LoginView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//


class LoginView: UIView {
    
    private let backImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pig")
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .setCustomFont(font: .black, size: 26)
        label.attributedText = "모두의 앱 로그인".underLine
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.backgroundColor = .systemBackground
        
        self.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(75)
            $0.height.equalTo(backImageView.snp.width)
        }
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.equalTo(backImageView.snp.bottom).offset(Design.padding)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import UIKit
import SnapKit
import Then
import AuthenticationServices


class NewLoginView: BaseView {
    
    private let ivLogo = UIImageView().then {
        $0.image = UIImage(named: "pig")
    }
    
    private let lblTitle = UILabel().then {
        $0.font = .setCustomFont(font: .black, size: 26)
        $0.attributedText = "모두의 앱 로그인".underLine
    }
    
    let btnApple = ASAuthorizationAppleIDButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [ivLogo, lblTitle, btnApple]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        ivLogo.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).multipliedBy(0.2)
            $0.left.right.equalToSuperview().inset(75)
            $0.height.equalTo(ivLogo.snp.width)
        }
        
        lblTitle.snp.makeConstraints {
            $0.top.equalTo(ivLogo.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        btnApple.snp.makeConstraints {
            $0.top.equalTo(lblTitle.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(btnApple.snp.width).multipliedBy(0.15)
        }
    }
}

//
//  LoginView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

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

//
//  TextFieldModalView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/11.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class TextFieldModalView: BaseView {
    
    let viewDismiss = UIView()
    
    private let viewMother = UIView().then {
        $0.addShadow(offset: .top, opacity: 0.3)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private let svTitle = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.gray10)
        $0.font = .setCustomFont(font: .bold, size: 18)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    private let lblSubTitle = UILabel().then {
        $0.textColor = .setCustomColor(.gray10)
        $0.font = .setCustomFont(font: .medium, size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let tfInput = UITextField().then {
        $0.addLeftPadding()
        $0.textColor = .setCustomColor(.gray10)
        $0.font = .setCustomFont(font: .medium, size: 16)
        $0.borderWidth = 1
        $0.borderColor = .setCustomColor(.gray1)
    }
    
    let btnConfirm = PyoButton(type: .system).then {
        $0.titleLabel?.font = .setCustomFont(font: .medium, size: 16)
    }
    
    var confirmInset: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        self.backgroundColor = .clear
        
        svTitle.addArrangedSubviews([lblTitle, lblSubTitle])
        
        viewMother.addSubviews([svTitle, tfInput, btnConfirm])
        
        self.addSubviews([viewDismiss, viewMother])
    }
    
    private func setLayout() {
        viewDismiss.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        viewMother.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
        }
        
        svTitle.snp.makeConstraints { make in
            make.top.equalTo(viewMother).inset(28)
            make.left.right.equalTo(viewMother).inset(20)
        }
        
        tfInput.snp.makeConstraints { make in
            make.top.equalTo(svTitle.snp.bottom).offset(20)
            make.left.right.equalTo(self).inset(20)
            make.height.equalTo(48)
        }
        
        btnConfirm.snp.makeConstraints { make in
            make.top.equalTo(tfInput.snp.bottom).offset(20)
            make.left.right.equalTo(viewMother).inset(20)
            confirmInset = make.bottom.equalTo(viewMother).inset(28).constraint
            make.height.equalTo(48)
        }
    }
    
    func setValue(title: String?, subTitle: String?, titleAlign: NSTextAlignment = .center,
                  placeholder: String?, tfType: UIKeyboardType = .default,
                  confirmTitle: String?, isFirstRespondse: Bool = false ) {
        lblTitle.text = title
        lblTitle.textAlignment = titleAlign
        
        subTitle.isNil ?
        lblSubTitle.removeFromSuperview() : (lblSubTitle.text = subTitle)
        
        tfInput.placeholder = placeholder
        tfInput.keyboardType = tfType
        
        btnConfirm.setTitle(confirmTitle, for: .normal)
        
        guard isFirstRespondse else { return }
        
        tfInput.becomeFirstResponder()
    }
}

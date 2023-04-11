//
//  TwoTapModalView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/11.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import SnapKit
import Then


class TwoTapModalView: BaseView {
    
    let viewDismiss = UIView()
    
    private let viewMother = UIView().then {
        $0.addShadow(offset: .top, opacity: 0.3)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    private let svModal = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 12
    }
    
    private let ivImage = UIImageView()
    
    private let svTitle = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 18)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    private let lblSubTitle = UILabel().then {
        $0.textColor = .setCustomColor(.gray6)
        $0.font = .setCustomFont(font: .regular, size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let svbuttons = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    let btnCancle = UIButton().then {
        $0.setTitleColor(.setCustomColor(.textBasic), for: .normal)
        $0.titleLabel?.font = .setCustomFont(font: .regular, size: 16)
        $0.borderColor = .setCustomColor(.gray2)
        $0.borderWidth = 1
    }
    
    let btnConfirm = PyoButton(type: .system).then {
        $0.titleLabel?.font = .setCustomFont(font: .regular, size: 16)
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
        self.backgroundColor = .clear
        
        svTitle.addArrangedSubviews([lblTitle, lblSubTitle])
        
        svModal.addArrangedSubviews([ivImage, svTitle])
        
        svbuttons.addArrangedSubviews([btnCancle, btnConfirm])
        
        viewMother.addSubviews([svModal, svbuttons])
        
        self.addSubviews([viewDismiss, viewMother])
    }
    
    private func setLayout() {
        viewDismiss.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        viewMother.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
        }
        
        ivImage.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }
        
        svModal.snp.makeConstraints { make in
            make.top.equalTo(viewMother).inset(28)
            make.left.right.equalTo(self)
        }
        
        svbuttons.snp.makeConstraints { make in
            make.top.equalTo(svModal.snp.bottom).offset(28)
            make.left.right.equalTo(viewMother).inset(20)
            make.bottom.equalTo(viewMother).inset(28)
            make.height.equalTo(48)
        }
    }
    
    func setValue(image: UIImage? = nil, title: String?, subTitle: String? = nil, cancelTitle: String?, confirmTitle: String?) {
        
        image.isNil ?
        ivImage.removeFromSuperview() : (ivImage.image = image)
        
        lblTitle.text = title
        
        subTitle.isNil ?
        lblSubTitle.removeFromSuperview() : (lblSubTitle.text = subTitle)
        
        btnCancle.setTitle(cancelTitle, for: .normal)
        btnConfirm.setTitle(confirmTitle, for: .normal)
    }
}

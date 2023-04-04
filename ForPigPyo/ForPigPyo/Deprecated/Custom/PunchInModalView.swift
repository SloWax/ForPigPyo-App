//
//  PunchInModalView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/04.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class PunchInModalView: UIView {
    
    let btnDismiss = UIButton().then {
        let image = UIImage(named: "xmark")
        $0.setImage(image, for: .normal)
        $0.tintColor = .setCustomColor(.textBasic)
    }
    
    private let svButtons = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    let btnPrevious = UIButton().then {
        let image = UIImage(named: "btn_chevron_left")
        $0.setImage(image, for: .normal)
        $0.tintColor = .setCustomColor(.textBasic)
    }
    
    let btnNext = UIButton().then {
        let image = UIImage(named: "btn_chevron_right")
        $0.setImage(image, for: .normal)
        $0.tintColor = .setCustomColor(.textBasic)
    }
    
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 18)
        $0.textAlignment = .center
    }
    
    private let lblSubTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .medium, size: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let vevPicker = UIVisualEffectView()
    let pvPicker = UIPickerView()
    
    let btnConfirm = PyoButton(type: .system).then {
        $0.titleLabel?.font = .setCustomFont(font: .medium, size: 16)
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
        self.addShadow(offset: .top)
        self.backgroundColor = .white
        self.cornerRadius = 10
        
        svButtons.addArrangedSubviews([btnPrevious, btnNext])
        
        vevPicker.contentView.addSubview(pvPicker)
        
        let views = [
            btnDismiss, svButtons,
            lblTitle, lblSubTitle,
            vevPicker, btnConfirm
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        btnDismiss.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(15)
            make.width.height.equalTo(28)
        }
        
        svButtons.snp.makeConstraints { make in
            make.top.right.equalTo(self).inset(15)
        }
        
        [btnPrevious, btnNext].forEach {
            $0.snp.makeConstraints { make in
                make.width.height.equalTo(28)
            }
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(self).inset(28)
            make.left.right.equalTo(self)
        }
        
        lblSubTitle.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom)
            make.left.right.equalTo(self)
        }
        
        vevPicker.snp.makeConstraints { make in
            make.top.equalTo(lblSubTitle.snp.bottom)
            make.left.right.equalTo(self).inset(20)
            make.height.equalTo(120)
        }
        
        pvPicker.snp.makeConstraints { make in
            make.edges.equalTo(vevPicker)
        }
        
        btnConfirm.snp.makeConstraints { make in
            make.top.equalTo(vevPicker.snp.bottom)
            make.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(self).inset(28)
            make.height.equalTo(48)
        }
    }
    
    func setValue(title: String?, subTitle: String?, confirmTitle: String?) {
        lblTitle.text = title
        lblSubTitle.text = subTitle
        
        btnConfirm.setTitle(confirmTitle, for: .normal)
    }
    
    func setDefaultRow(_ rows: [(component: Int, row: Int)]) {
        rows.forEach {
            pvPicker.selectRow($0.row, inComponent: $0.component, animated: false)
        }
    }
}

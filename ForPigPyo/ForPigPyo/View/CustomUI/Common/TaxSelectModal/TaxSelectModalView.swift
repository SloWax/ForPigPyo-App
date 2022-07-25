//
//  TaxSelectModalView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/25.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class TaxSelectModalView: BaseView {
    
    let viewDismiss = UIView()
    
    private let viewMother = UIView().then {
        $0.addShadow(offset: .top)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 18)
        $0.textAlignment = .center
    }
    
    private let vevPicker = UIVisualEffectView()
    let pvPicker = UIPickerView()
    
    let btnConfirm = UIButton().then {
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
        self.backgroundColor = .clear
        
        vevPicker.contentView.addSubview(pvPicker)
        
        let views = [lblTitle, vevPicker, btnConfirm]
        viewMother.addSubviews(views)
        
        self.addSubviews([viewDismiss, viewMother])
    }
    
    private func setLayout() {
        viewDismiss.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        viewMother.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(viewMother).inset(28)
            make.left.right.equalTo(self)
        }
        
        vevPicker.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(28)
            make.left.right.equalTo(self).inset(20)
            make.height.equalTo(176)
        }
        
        pvPicker.snp.makeConstraints { make in
            make.edges.equalTo(vevPicker)
        }
        
        btnConfirm.snp.makeConstraints { make in
            make.top.equalTo(vevPicker.snp.bottom).offset(28)
            make.left.right.equalTo(viewMother).inset(20)
            make.bottom.equalTo(viewMother).inset(28)
            make.height.equalTo(48)
        }
    }
    
    func setValue(title: String?, confirmTitle: String?) {
        lblTitle.text = title
        
        btnConfirm.setTitle(confirmTitle, for: .normal)
    }
    
    func setCenterRow(_ list: [[Int]]) {
        list.enumerated().forEach { row, items in
            pvPicker.selectRow(items.count / 2, inComponent: row, animated: false)
        }
    }
}

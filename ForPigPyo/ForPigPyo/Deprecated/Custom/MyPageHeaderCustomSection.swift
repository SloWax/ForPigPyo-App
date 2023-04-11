//
//  MyPageHeaderCustomSection.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import Then
import SnapKit


class MyPageHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "MyPageHeaderView"
    
    private let lblTitle = UILabel().then {
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setUP()
        setLayout()
    }
    
    private func setUP() {
        let backColor: UIColor = .systemBackground
        contentView.backgroundColor = backColor.withAlphaComponent(0.65)
        
        contentView.addSubview(lblTitle)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Design.smallPadding)
        }
    }
    
    func setValue(title: String) {
        lblTitle.text = title
    }
}

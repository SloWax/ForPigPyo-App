//
//  MyPageView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/23.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import Then
import SnapKit


class MyPageView: BaseView {

    private let lblTitle = UILabel().then {
        $0.attributedText = "내 정보".underLine
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
    
    let tvList = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
//        $0.dataSource = self
//        $0.delegate = self
        $0.register(MyPageCustomCell.self, forCellReuseIdentifier: MyPageCustomCell.identifier)
        $0.register(MyPageHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderView.identifier)
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
        let views = [lblTitle, tvList]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).multipliedBy(0.1)
            $0.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        tvList.snp.makeConstraints {
            $0.top.equalTo(lblTitle.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.bottom.equalTo(self)
        }
    }
}

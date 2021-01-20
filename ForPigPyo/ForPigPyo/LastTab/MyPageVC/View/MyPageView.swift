//
//  MyPageView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/23.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class MyPageView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.boldNomalTextSize
        label.text = "급여 계산기"
        
        return label
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.equalTo(self.snp.bottom).multipliedBy(0.1)
            $0.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

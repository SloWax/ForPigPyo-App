//
//  MyPageHeaderCustomSection.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// MyPageVC tableView CustomSection

class MyPageHeaderCustomSection: UITableViewHeaderFooterView {
    
    static let identifier = "MyPageHeaderCustomSection"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.purple
        label.font = Design.boldNomalTextSize
        
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        
        setView()
        setHeaderLabel()
    }
    private func setView() {
        
        let backColor: UIColor = .systemBackground
        
        contentView.backgroundColor = backColor.withAlphaComponent(0.65)
    }
    private func setHeaderLabel() {
        
        contentView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview().inset(Design.smallPadding)
        }
    }
    func setValue(title: String) {
        
        headerLabel.text = title
    }
}

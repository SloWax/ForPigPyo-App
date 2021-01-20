//
//  SavingAdminView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingAdminView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        label.text = "저축액 관리하기"
        
        return label
    }()
    
    let containerView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "지금까지 얼마나 모았을까요?"
        view.label1.font = Design.boldSmallTextSize
        
        view.label2.text = "0 원"
        view.label2.font = Design.boldNomalTextSize
        
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setTitle("저축 추가", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.backgroundColor = Design.yellow
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.padding)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.label1.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.nomalPadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding)
        }
        
        containerView.label2.snp.makeConstraints {
            $0.top.equalTo(containerView.label1.snp.bottom).offset(Design.smallPadding)
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(containerView.label2.snp.bottom).offset(Design.largestPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            
            $0.width.equalToSuperview().multipliedBy(0.26)
            $0.height.equalTo(addButton.snp.width).multipliedBy(0.5)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview().inset(Design.padding)
        }
    }
    
    func setValue(allSave: Int) {
        
        let fomatter: NumberFormatter = {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            
            return format
        }()
        
        containerView.label2.text = "\(fomatter.string(from: allSave as NSNumber) ?? "0") 원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

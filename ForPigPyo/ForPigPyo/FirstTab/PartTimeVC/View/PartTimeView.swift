//
//  PartTimeView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// PartTimeVC 전체 View

class PartTimeView: UIView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.headerTextSize
        
        return label
    }()
    let preButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    let nexButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.lightGray
        view.layer.cornerRadius = Design.cornerRadius
        
        return view
    }()
    let explainLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달에는 얼마를 받을까요?"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    let taxButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Design.textBasic
        button.titleLabel?.font = Design.boldSmallTextSize
        button.backgroundColor = Design.gray
        button.layer.cornerRadius = Design.oneFifthCornerRadius
        
        return button
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "총 급여: 0 원"
        label.textColor = Design.textBasic
        label.font = Design.boldNomalTextSize
        
        return label
    }()
    
    let historyTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setTitle("근무 추가", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.backgroundColor = Design.yellow
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDateLabel()
        setButtons()
        setTotalContainer()
        setHistoryTable()
        setAddButton()
    }
    private func setDateLabel() {
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(Design.padding)
        }
    }
    private func setButtons() {
        
        self.addSubview(preButton)
        self.addSubview(nexButton)
        
        preButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalToSuperview().inset(Design.padding)
        }
        nexButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(Design.padding)
        }
    }
    private func setTotalContainer() {
        
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.addSubview(explainLabel)
        
        explainLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.nomalPadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding)
        }
        
        containerView.addSubview(taxButton)
        
        taxButton.snp.makeConstraints {
            $0.top.equalTo(explainLabel)
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(taxButton.snp.width).multipliedBy(0.37)
        }
        
        containerView.addSubview(totalLabel)
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(taxButton.snp.bottom).offset(Design.smallPadding)
            $0.trailing.equalTo(taxButton)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    private func setHistoryTable() {
        
        self.addSubview(historyTable)
        
        historyTable.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setAddButton() {
        
        self.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            
            $0.width.equalToSuperview().multipliedBy(0.26)
            $0.height.equalTo(addButton.snp.width).multipliedBy(0.5)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview().inset(Design.padding)
        }
    }
    
    func setValue(year: Int, month: Int, totalPay: String) {
        
        dateLabel.text = "\(year)년 \(month)월"
        totalLabel.text = "총 급여: \(totalPay) 원"
    }
    func setButtonTitle(title: String) {
        
        taxButton.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

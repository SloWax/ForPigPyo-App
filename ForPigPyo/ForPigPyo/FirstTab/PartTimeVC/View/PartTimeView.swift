//
//  PartTimeView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class PartTimeView: UIView {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldLargeTextSize
        
        return label
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "총 0 원"
        label.textColor = Design.textBasic
        label.font = Design.boldLargeTextSize
        
        return label
    }()
    let deductionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Design.purple
        button.titleLabel?.font = Design.boldSmallTextSize
        button.backgroundColor = Design.textBasic
        button.layer.cornerRadius = Design.qurterCornerRadius
        
        return button
    }()
    let deduction: [String] = ["미공제", "3.3%", "4대보험"]
    
    let preButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Design.textBasic
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    let nexButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Design.textBasic
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        return button
    }()
    
    let historyTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = Design.textBasic
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDateLabel()
        setTotalLabel()
        setButtons()
        setDeductionButton()
        setHistoryTable()
    }
    private func setDateLabel() {
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(Design.padding)
        }
    }
    private func setTotalLabel() {
        
        self.addSubview(totalLabel)
        
        totalLabel.snp.makeConstraints {
            $0.centerX.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(Design.padding)
        }
    }
    private func setButtons() {
        
        self.addSubview(preButton)
        self.addSubview(nexButton)
        
        preButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel)
            $0.leading.equalToSuperview().inset(Design.padding)
        }
        nexButton.snp.makeConstraints {
            $0.top.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(Design.padding)
        }
    }
    private func setDeductionButton() {
        
        self.addSubview(deductionButton)
        
        deductionButton.snp.makeConstraints {
            $0.bottom.equalTo(totalLabel)
            $0.trailing.equalTo(nexButton)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
    }
    private func setHistoryTable() {
        
        self.addSubview(historyTable)
        
        historyTable.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    func setValue(year: Int, month: Int, totalPay: String) {
        
        dateLabel.text = "\(year)년 \(month)월"
        totalLabel.text = "총 \(totalPay) 원"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        label.textColor = .white
        label.font = Design.boldLargeTextSize
        
        return label
    }()
    let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월"
        
        return format
    }()
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "총 0 원"
        label.textColor = .white
        label.font = Design.boldLargeTextSize
        
        return label
    }()
    
    let preButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    let nexButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        return button
    }()
    
    let historyTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        
        return tableView
    }()
    
    let contentsView: PartTimeContentView = {
        let view = PartTimeContentView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDateLabel()
        setTotalLabel()
        setButtons()
        setHistoryTable()
    }
    private func setDateLabel() {
        
        dateLabel.text = dateFormat.string(from: Date())
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
    private func setHistoryTable() {
        
        self.addSubview(historyTable)
        
        historyTable.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

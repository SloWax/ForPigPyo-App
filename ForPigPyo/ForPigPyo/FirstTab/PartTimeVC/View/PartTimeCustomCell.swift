//
//  PartTimeCustomCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class PartTimeCustomCell: UITableViewCell {
    
    static let identifier = "PartCustomItem"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        label.text = "1일"
        
        return label
    }()
    let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "dd일"
        
        return format
    }()
    
    let workTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.smallTextSize
        label.text = "1시간"
        
        return label
    }()
    let overTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.smallTextSize
        label.text = "1시간"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setDateLabel()
        setworkTimeLabel()
        setOverTimeLabel()
    }
    private func setDateLabel() {
        
        dateLabel.text = dateFormat.string(from: Date())
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Design.smallPadding)
        }
    }
    private func setworkTimeLabel() {
        
        contentView.addSubview(workTimeLabel)
        
        workTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(Design.nomalPadding)
        }
    }
    private func setOverTimeLabel() {
        
        contentView.addSubview(overTimeLabel)
        
        overTimeLabel.snp.makeConstraints {
            $0.top.equalTo(workTimeLabel.snp.bottom).offset(Design.smallPadding)
            $0.leading.equalTo(workTimeLabel)
            $0.bottom.equalToSuperview().inset(Design.smallPadding)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

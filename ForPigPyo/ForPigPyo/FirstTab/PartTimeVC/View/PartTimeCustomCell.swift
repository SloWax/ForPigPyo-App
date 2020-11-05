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
        label.font = Design.boldLargeTextSize
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
        label.font = Design.nomalTextSize
        label.text = "근무시간: 1시간"
        
        return label
    }()
    let overTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        label.text = "추가 근무시간: 1시간"
        
        return label
    }()
    let hourlyWageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        label.text = "시급: 5,000원"
        
        return label
    }()
    let totalPayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.boldNomalTextSize
        label.text = "총급여: 12,500원"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setDateLabel()
        setworkTimeLabel()
        setOverTimeLabel()
        setHourlyWageLabel()
        setTotalPayLabel()
    }
    private func setDateLabel() {
        
        dateLabel.text = dateFormat.string(from: Date())
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Design.LargePadding)
            $0.centerY.equalToSuperview()
        }
    }
    private func setworkTimeLabel() {
        
        contentView.addSubview(workTimeLabel)
        
        workTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.nomalPadding)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(Design.LargePadding)
        }
    }
    private func setOverTimeLabel() {
        
        contentView.addSubview(overTimeLabel)
        
        overTimeLabel.snp.makeConstraints {
            $0.top.equalTo(workTimeLabel.snp.bottom).offset(Design.smallPadding)
            $0.leading.equalTo(workTimeLabel)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    private func setHourlyWageLabel() {
        
        contentView.addSubview(hourlyWageLabel)
        
        hourlyWageLabel.snp.makeConstraints {
            $0.top.equalTo(workTimeLabel.snp.top)
            $0.trailing.equalToSuperview().inset(Design.LargePadding)
        }
    }
    private func setTotalPayLabel() {
        
        contentView.addSubview(totalPayLabel)
        
        totalPayLabel.snp.makeConstraints {
            $0.trailing.equalTo(hourlyWageLabel.snp.trailing)
            $0.bottom.equalTo(overTimeLabel.snp.bottom)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        
        return label
    }()
    
    let overTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    let nightWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    let overNightWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        
        return label
    }()
    
    
    let hourlyWageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        
        return label
    }()
    let totalWorkTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.nomalTextSize
        
        return label
    }()
    let dayPayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.boldNomalTextSize
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setDateLabel()
        
        setOverTimeLabel()
        setNightWorkLabel()
        setOverNightWorkLabel()
        
        setHourlyWageLabel()
        setTotalWorkTimeLabel()
        setTotalPayLabel()
    }
    private func setDateLabel() {
        
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Design.LargePadding)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setOverTimeLabel() {
        
        contentView.addSubview(overTimeLabel)
        
        overTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.nomalPadding)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(Design.nomalPadding)
        }
    }
    private func setNightWorkLabel() {
        
        contentView.addSubview(nightWorkLabel)
        
        nightWorkLabel.snp.makeConstraints {
            $0.top.equalTo(overTimeLabel.snp.bottom).offset(Design.smallPadding / 2)
            $0.leading.equalTo(overTimeLabel)
        }
    }
    private func setOverNightWorkLabel() {
        
        contentView.addSubview(overNightWorkLabel)
        
        overNightWorkLabel.snp.makeConstraints {
            $0.top.equalTo(nightWorkLabel.snp.bottom).offset(Design.smallPadding / 2)
            $0.leading.equalTo(nightWorkLabel)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
    }
    
    private func setHourlyWageLabel() {
        
        contentView.addSubview(hourlyWageLabel)
        
        hourlyWageLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Design.LargePadding)
            $0.bottom.equalTo(overTimeLabel)
        }
    }
    private func setTotalWorkTimeLabel() {
        
        contentView.addSubview(totalWorkTimeLabel)
        
        totalWorkTimeLabel.snp.makeConstraints {
            $0.trailing.equalTo(hourlyWageLabel)
            $0.bottom.equalTo(nightWorkLabel)
        }
    }
    private func setTotalPayLabel() {
        
        contentView.addSubview(dayPayLabel)
        
        dayPayLabel.snp.makeConstraints {
            $0.trailing.equalTo(totalWorkTimeLabel)
            $0.bottom.equalTo(overNightWorkLabel)
        }
    }
    
    func setValue(data:  PayList.Year.Month.Data?) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        dateLabel.text = "\(String(format: "%02d", data?.date ?? 0))일"
        
        overTimeLabel.text = "특근: \(data?.overTime ?? 0)시간 \(data?.overTimeMin ?? 0)분"
        nightWorkLabel.text = "야간: \(data?.nightTime ?? 0)시간 \(data?.nightTimeMin ?? 0)분"
        overNightWorkLabel.text = "야간 특근: \(data?.overNightTime ?? 0)시간 \(data?.overNightTimeMin ?? 0)분"
        
        hourlyWageLabel.text = "시급: \(formatter.string(from: (data?.hourlyWage ?? 0) as NSNumber) ?? "")원"
        totalWorkTimeLabel.text = "총 근무: \(data?.workingTime ?? 0)시간 \(data?.workingTimeMin ?? 0)분"
        dayPayLabel.text = "일 급여: \(formatter.string(from: (data?.totalPay ?? 0) as NSNumber) ?? "")원"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

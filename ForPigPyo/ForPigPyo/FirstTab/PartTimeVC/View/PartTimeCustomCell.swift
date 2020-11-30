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
    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.boldLargeTextSize
        
        return label
    }()
    
    let overTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.smallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    let nightWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.smallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    let overNightWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Design.smallTextSize
        
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
        setWeekDayLabel()
        
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
            $0.bottom.equalTo(self.snp.centerY).offset(-Design.smallPadding / 2)
        }
    }
    private func setWeekDayLabel() {
        
        contentView.addSubview(weekDayLabel)
        
        weekDayLabel.snp.makeConstraints {
            $0.centerX.equalTo(dateLabel.snp.centerX)
            $0.top.equalTo(self.snp.centerY).offset(Design.smallPadding / 2)
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
            $0.top.equalTo(overTimeLabel.snp.bottom).offset(Design.smallPadding)
            $0.leading.equalTo(overTimeLabel)
        }
    }
    private func setOverNightWorkLabel() {
        
        contentView.addSubview(overNightWorkLabel)
        
        overNightWorkLabel.snp.makeConstraints {
            $0.top.equalTo(nightWorkLabel.snp.bottom).offset(Design.smallPadding)
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
    private func setOverText(data: PayList.Year.Month.Data?) {
        
        let overTimeMin = data?.overTimeMin ?? 0
        
        if overTimeMin == 0 {
            
            overTimeLabel.text = "특근: \(data?.overTime ?? 0)시간"
        } else {
            overTimeLabel.text = "특근: \(data?.overTime ?? 0)시간 \(overTimeMin)분"
        }
    }
    private func setNightText(data: PayList.Year.Month.Data?) {
        
        let nightTimeMin = data?.nightTimeMin ?? 0
        
        if nightTimeMin == 0 {
            
            nightWorkLabel.text = "야간: \(data?.nightTime ?? 0)시간"
        } else {
            nightWorkLabel.text = "야간: \(data?.nightTime ?? 0)시간 \(nightTimeMin)분"
        }
    }
    private func setOverNightText(data: PayList.Year.Month.Data?) {
        
        let overNightTimeMin = data?.overNightTimeMin ?? 0
        
        if overNightTimeMin == 0 {
            
            overNightWorkLabel.text = "야/특근: \(data?.overNightTime ?? 0)시간"
        } else {
            overNightWorkLabel.text = "야/특근: \(data?.overNightTime ?? 0)시간 \(overNightTimeMin)분"
        }
    }
    private func setWeekLabelColor(label: UILabel, weakDay: String?) {
        switch weakDay {
        case "일":
            
            label.textColor = Design.redSun
        case "토":
            
            label.textColor = Design.blueSat
        default:
            label.textColor = Design.basic
        }
    }
    func setValue(data: PayList.Year.Month.Data?) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        dateLabel.text = "\(String(format: "%02d", data?.date ?? 0))일"
        weekDayLabel.text = data?.weekDay
        setWeekLabelColor(label: weekDayLabel, weakDay: data?.weekDay)
        
        
        setOverText(data: data)
        setNightText(data: data)
        setOverNightText(data: data)
        
        hourlyWageLabel.text = "시급: \(formatter.string(from: (data?.hourlyWage ?? 0) as NSNumber) ?? "")원"
        totalWorkTimeLabel.text = "총 근무: \(data?.totalTime ?? "")"
        dayPayLabel.text = "일 급여: \(formatter.string(from: (data?.totalPay ?? 0) as NSNumber) ?? "")원"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

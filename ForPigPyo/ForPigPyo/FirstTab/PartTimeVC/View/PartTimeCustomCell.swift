//
//  PartTimeCustomCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// PartTimeVC tableView CustomCell

class PartTimeCustomCell: UITableViewCell {
    
    static let identifier = "PartCustomCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.lightGray
        view.layer.cornerRadius = Design.cornerRadius
        
        return view
    }()
    
    private let overTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "특근:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    private let nightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야간:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    private let overNightWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "야/특근:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    
    private let overTime: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    private let nightTime: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        return label
    }()
    private let overNightTime: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    
    
    private let hourlyWageLabel: UILabel = {
        let label = UILabel()
        label.text = "시급:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    private let totalWorkTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "총 근무:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    private let dayPayLabel: UILabel = {
        let label = UILabel()
        label.text = "일 급여:"
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    
    private let hourlyWageValue: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    private let totalWorkValue: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    private let dayPayValue: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.boldSmallTextSize
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setDateLabel()
        setWeekDayLabel()
        
        setContainerView()
        setTimeLabel()
        setValueLabel()
    }
    private func setDateLabel() {
        
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding + Design.largePadding)
        }
    }
    private func setWeekDayLabel() {
        
        contentView.addSubview(weekDayLabel)
        
        weekDayLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(Design.smallPadding)
        }
    }
    
    private func setContainerView() {
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview()
        }
        
        containerView.addSubview(overTimeLabel)
        
        overTimeLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalTo(dateLabel.snp.leading)
        }
        
        containerView.addSubview(nightWorkLabel)
        
        nightWorkLabel.snp.makeConstraints {
            $0.top.equalTo(overTimeLabel.snp.bottom)
            $0.leading.equalTo(overTimeLabel)
        }
        
        containerView.addSubview(overNightWorkLabel)
        
        overNightWorkLabel.snp.makeConstraints {
            $0.top.equalTo(nightWorkLabel.snp.bottom)
            $0.leading.equalTo(nightWorkLabel)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
        
        
        containerView.addSubview(hourlyWageLabel)
        
        hourlyWageLabel.snp.makeConstraints {
            
            $0.leading.equalTo(containerView.snp.centerX).offset(Design.largePadding)
            $0.bottom.equalTo(overTimeLabel)
        }
        
        containerView.addSubview(totalWorkTimeLabel)
        
        totalWorkTimeLabel.snp.makeConstraints {
            
            $0.leading.equalTo(hourlyWageLabel)
            $0.bottom.equalTo(nightWorkLabel)
        }
        
        containerView.addSubview(dayPayLabel)
        
        dayPayLabel.snp.makeConstraints {
            
            $0.leading.equalTo(totalWorkTimeLabel)
            $0.bottom.equalTo(overNightWorkLabel)
        }
    }
    private func setTimeLabel() {
        
        containerView.addSubview(overTime)
        
        overTime.snp.makeConstraints {
            $0.top.equalTo(overTimeLabel)
            $0.trailing.equalTo(containerView.snp.centerX).inset(Design.smallPadding)
        }
        
        containerView.addSubview(nightTime)
        
        nightTime.snp.makeConstraints {
            $0.top.equalTo(nightWorkLabel)
            $0.trailing.equalTo(overTime.snp.trailing)
        }
        
        containerView.addSubview(overNightTime)
        
        overNightTime.snp.makeConstraints {
            $0.top.equalTo(overNightWorkLabel)
            $0.trailing.equalTo(nightTime.snp.trailing)
        }
    }
    private func setValueLabel() {
        
        containerView.addSubview(hourlyWageValue)
        
        hourlyWageValue.snp.makeConstraints {
            
            $0.top.equalTo(hourlyWageLabel)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.addSubview(totalWorkValue)
        
        totalWorkValue.snp.makeConstraints {
            
            $0.top.equalTo(totalWorkTimeLabel)
            $0.trailing.equalTo(hourlyWageValue)
        }
        
        containerView.addSubview(dayPayValue)
        
        dayPayValue.snp.makeConstraints {
            
            $0.top.equalTo(dayPayLabel)
            $0.trailing.equalTo(totalWorkValue)
        }
    }
    
    private func setTimeText(label: UILabel, data: PayList.Year.Month.Data?) {
        
        switch label {
        case overTime:
            let overTimeMin = data?.overTimeMin ?? 0
            
            if overTimeMin == 0 {
                
                overTime.text = "\(data?.overTime ?? 0)시간"
            } else {
                overTime.text = "\(data?.overTime ?? 0)시간 \(overTimeMin)분"
            }
            
        case nightTime :
            let nightTimeMin = data?.nightTimeMin ?? 0
            
            if nightTimeMin == 0 {
                
                nightTime.text = "\(data?.nightTime ?? 0)시간"
            } else {
                nightTime.text = "\(data?.nightTime ?? 0)시간 \(nightTimeMin)분"
            }
        case overNightTime :
            let overNightTimeMin = data?.overNightTimeMin ?? 0
            
            if overNightTimeMin == 0 {
                
                overNightTime.text = "\(data?.overNightTime ?? 0)시간"
            } else {
                overNightTime.text = "\(data?.overNightTime ?? 0)시간 \(overNightTimeMin)분"
            }
        default:
            fatalError()
        }
    }
    private func setWeekLabelColor(label: UILabel, weakDay: String?) {
        switch weakDay {
        case "일":
            
            label.textColor = Design.textRedSun
        case "토":
            
            label.textColor = Design.textBlueSat
        default:
            label.textColor = Design.textBasic
        }
    }
    
    func setValue(data: PayList.Year.Month.Data?) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        dateLabel.text = "\(String(format: "%02d", data?.date ?? 0))일"
        weekDayLabel.text = data?.weekDay
        setWeekLabelColor(label: weekDayLabel, weakDay: data?.weekDay)
        
        [overTime, nightTime, overNightTime].forEach { (label) in
            setTimeText(label: label, data: data)
        }
        
        hourlyWageValue.text = "\(formatter.string(from: (data?.hourlyWage ?? 0) as NSNumber) ?? "")원"
        totalWorkValue.text = "\(data?.totalTime ?? "")"
        dayPayValue.text = "\(formatter.string(from: (data?.totalPay ?? 0) as NSNumber) ?? "")원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

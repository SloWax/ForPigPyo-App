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
        
        return label
    }()
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "특근:"
        
        view.label2.text = "야간:"
        
        view.label3.text = "야/특근:"
        
        view.label4.text = "시급:"
        
        view.label5.text = "총 근무:"
        
        view.label6.text = "일 급여:"
        
        return view
    }()
    
    private let overTime: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let nightTime: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let overNightTime: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let hourlyWageValue: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let totalWorkValue: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let dayPayValue: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setDate()
        
        setContainerView()
        setTimeLabel()
        setValueLabel()
    }
    private func setDate() {
        
        [dateLabel, weekDayLabel].forEach {
            $0.textColor = .setCustomColor(.textBasic)
            $0.font = Design.boldSmallTextSize
        }
        
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding + Design.largePadding)
        }
        
        contentView.addSubview(weekDayLabel)
        
        weekDayLabel.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(Design.smallPadding)
        }
    }
    
    private func setContainerView() {
        
        containerView.labelBundle.forEach { $0.font = Design.boldSmallTextSize }
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview()
        }
        
        containerView.label1.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalTo(dateLabel.snp.leading)
        }
        
        containerView.label2.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label1.snp.bottom)
            $0.leading.equalTo(containerView.label1)
        }
        
        containerView.label3.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label2.snp.bottom)
            $0.leading.equalTo(containerView.label2)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
        
        containerView.label4.snp.makeConstraints {
            
            $0.leading.equalTo(containerView.snp.centerX).offset(Design.largePadding)
            $0.bottom.equalTo(containerView.label1)
        }
        
        containerView.label5.snp.makeConstraints {
            
            $0.leading.equalTo(containerView.label4)
            $0.bottom.equalTo(containerView.label2)
        }
        
        containerView.label6.snp.makeConstraints {
            
            $0.leading.equalTo(containerView.label5)
            $0.bottom.equalTo(containerView.label3)
        }
    }
    private func setTimeLabel() {
        
        [overTime, nightTime, overNightTime].forEach {
            
            $0.textColor = .setCustomColor(.textBasic)
            $0.font = Design.boldSmallTextSize
        }
        
        containerView.addSubview(overTime)
        
        overTime.snp.makeConstraints {
            $0.top.equalTo(containerView.label1)
            $0.trailing.equalTo(containerView.snp.centerX).inset(Design.smallPadding)
        }
        
        containerView.addSubview(nightTime)
        
        nightTime.snp.makeConstraints {
            $0.top.equalTo(containerView.label2)
            $0.trailing.equalTo(overTime.snp.trailing)
        }
        
        containerView.addSubview(overNightTime)
        
        overNightTime.snp.makeConstraints {
            $0.top.equalTo(containerView.label3)
            $0.trailing.equalTo(nightTime.snp.trailing)
        }
    }
    private func setValueLabel() {
        
        [hourlyWageValue, totalWorkValue, dayPayValue].forEach {
            
            $0.textColor = .setCustomColor(.textBasic)
            $0.font = Design.boldSmallTextSize
        }
        
        containerView.addSubview(hourlyWageValue)
        
        hourlyWageValue.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label4)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.addSubview(totalWorkValue)
        
        totalWorkValue.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label5)
            $0.trailing.equalTo(hourlyWageValue)
        }
        
        containerView.addSubview(dayPayValue)
        
        dayPayValue.snp.makeConstraints {
            
            $0.top.equalTo(containerView.label6)
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
            
            label.textColor = .setCustomColor(.textRed)
        case "토":
            
            label.textColor = .setCustomColor(.textBlue)
        default:
            
            label.textColor = .setCustomColor(.textBasic)
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
        
        hourlyWageValue.text = "\(formatter.string(from: (data?.hourlyWage ?? 0) as NSNumber) ?? "0")원"
        totalWorkValue.text = "\(data?.totalTime ?? "0 시간 0 분")"
        dayPayValue.text = "\(formatter.string(from: (data?.totalPay ?? 0) as NSNumber) ?? "0")원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

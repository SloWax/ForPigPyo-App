//
//  TimeCardCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/03/30.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import SnapKit
import Then

class TimeCardCell: UITableViewCell {
    
    static let id = "TimeCardCell"
    
    private let lblDate = UILabel().then {
        $0.font = .setCustomFont(font: .bold, size: 14)
    }
    
    private let viewContainer = UIView().then {
        $0.backgroundColor = .setCustomColor(.lightGray)
        $0.cornerRadius = 25
    }
    
    private let lblOver = UILabel().then { $0.text = "특근:" }
    private let lblOverValue = UILabel()
    
    private let lblNight = UILabel().then { $0.text = "야간:" }
    private let lblNightValue = UILabel()
    
    private let lblOverNight = UILabel().then { $0.text = "야/특근:" }
    private let lblOverNightValue = UILabel()
    
    private let lblWage = UILabel().then { $0.text = "시급:" }
    private let lblWageValue = UILabel()
    
    private let lblTotal = UILabel().then { $0.text = "총 근무:" }
    private let lblTotalValue = UILabel()
    
    private let lblDayPay = UILabel().then { $0.text = "일 급여:" }
    private let lblDayPayValue = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        lblDate.textColor = .setCustomColor(.textBasic)
    }
    
    private func setUP() {
        let labels = [
            lblOver, lblOverValue,
            lblNight, lblNightValue,
            lblOverNight, lblOverNightValue,
            lblWage, lblWageValue,
            lblTotal, lblTotalValue,
            lblDayPay, lblDayPayValue
        ]
        
        labels.forEach {
            $0.textColor = .setCustomColor(.textBasic)
            $0.font = .setCustomFont(font: .bold, size: 14)
        }
        
        viewContainer.addSubviews(labels)
        
        let views = [lblDate, viewContainer]
        contentView.addSubviews(views)
    }
    
    private func setLayout() {
        lblDate.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(5)
            $0.left.equalTo(contentView).inset(35)
        }
        
        viewContainer.snp.makeConstraints {
            $0.top.equalTo(lblDate.snp.bottom)
            $0.left.right.equalTo(contentView).inset(15)
            $0.bottom.equalTo(contentView)
        }
      
        lblOver.snp.makeConstraints {
            $0.top.equalTo(viewContainer).inset(5)
            $0.left.equalTo(lblDate)
        }
        
        lblNight.snp.makeConstraints {
            $0.top.equalTo(lblOver.snp.bottom)
            $0.left.equalTo(lblOver)
        }
        
        lblOverNight.snp.makeConstraints {
            $0.top.equalTo(lblNight.snp.bottom)
            $0.left.equalTo(lblNight)
            $0.bottom.equalTo(contentView).inset(5)
        }
        
        lblOverValue.snp.makeConstraints {
            $0.centerY.equalTo(lblOver)
            $0.right.equalTo(viewContainer.snp.centerX).inset(5)
        }
        
        lblNightValue.snp.makeConstraints {
            $0.centerY.equalTo(lblNight)
            $0.right.equalTo(lblOverValue)
        }
        
        lblOverNightValue.snp.makeConstraints {
            $0.centerY.equalTo(lblOverNight)
            $0.right.equalTo(lblNightValue)
        }
        
        lblWage.snp.makeConstraints {
            $0.centerY.equalTo(lblOverValue)
            $0.left.equalTo(viewContainer.snp.centerX).offset(15)
        }
        
        lblTotal.snp.makeConstraints {
            $0.centerY.equalTo(lblNightValue)
            $0.left.equalTo(lblWage)
        }
        
        lblDayPay.snp.makeConstraints {
            $0.centerY.equalTo(lblOverNightValue)
            $0.left.equalTo(lblTotal)
        }
        
        lblWageValue.snp.makeConstraints {
            $0.centerY.equalTo(lblWage)
            $0.right.equalTo(viewContainer).inset(15)
        }
        
        lblTotalValue.snp.makeConstraints {
            $0.centerY.equalTo(lblTotal)
            $0.right.equalTo(lblWageValue)
        }
        
        lblDayPayValue.snp.makeConstraints {
            $0.centerY.equalTo(lblDayPay)
            $0.right.equalTo(lblTotalValue)
        }
    }
    
    func setValue(_ data: TimeCardModel.Attendance) {
        let date = data.date
        lblDate.text = date.toString(dateFormat: "d일 (eee)")
        
        switch date.toString(dateFormat: "e") {
        case "1": lblDate.textColor = .setCustomColor(.primaryRed)
        case "7": lblDate.textColor = .setCustomColor(.primaryBlue)
        default: break
        }
        
        let overHour = data.overTime.hour
        let overMin = data.overTime.min
        let overValue = overMin == 0 ? "\(overHour)시간" : "\(overHour)시간 \(overMin)분"
        lblOverValue.text = overValue
        
        let nightHour = data.nightTime.hour
        let nightMin = data.nightTime.min
        let nightValue = nightMin == 0 ? "\(nightHour)시간" : "\(overHour)시간 \(overMin)분"
        lblNightValue.text = nightValue
        
        let overNightHour = data.overNightTime.hour
        let overNightMin = data.overNightTime.min
        let overNightValue = overNightMin == 0 ? "\(overNightHour)시간" : "\(overNightHour)시간 \(overNightMin)분"
        lblOverNightValue.text = overNightValue
        
        let wage = data.wage.comma.won
        lblWageValue.text = wage
        
        let totalHour = data.total.hour
        let totalMin = data.total.min
        let totalValue = totalMin == 0 ? "\(totalHour)시간" : "\(totalHour)시간 \(totalMin)분"
        lblTotalValue.text = totalValue
        
        let dayPay = data.dayPay.comma.won
        lblDayPayValue.text = dayPay
    }
}

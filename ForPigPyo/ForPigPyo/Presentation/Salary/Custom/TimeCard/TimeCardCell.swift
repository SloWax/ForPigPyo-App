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
        
    }
        
//
//    private func setTimeText(label: UILabel, data: PayList.Year.Month.Data?) {
//
//        switch label {
//        case overTime:
//            let overTimeMin = data?.overTimeMin ?? 0
//
//            if overTimeMin == 0 {
//
//                overTime.text = "\(data?.overTime ?? 0)시간"
//            } else {
//                overTime.text = "\(data?.overTime ?? 0)시간 \(overTimeMin)분"
//            }
//
//        case nightTime :
//            let nightTimeMin = data?.nightTimeMin ?? 0
//
//            if nightTimeMin == 0 {
//
//                nightTime.text = "\(data?.nightTime ?? 0)시간"
//            } else {
//                nightTime.text = "\(data?.nightTime ?? 0)시간 \(nightTimeMin)분"
//            }
//        case overNightTime :
//            let overNightTimeMin = data?.overNightTimeMin ?? 0
//
//            if overNightTimeMin == 0 {
//
//                overNightTime.text = "\(data?.overNightTime ?? 0)시간"
//            } else {
//                overNightTime.text = "\(data?.overNightTime ?? 0)시간 \(overNightTimeMin)분"
//            }
//        default:
//            fatalError()
//        }
//    }
//    private func setWeekLabelColor(label: UILabel, weakDay: String?) {
//
//        switch weakDay {
//        case "일":
//
//            label.textColor = .setCustomColor(.textRed)
//        case "토":
//
//            label.textColor = .setCustomColor(.textBlue)
//        default:
//
//            label.textColor = .setCustomColor(.textBasic)
//        }
//    }
//    func setValue(data: PayList.Year.Month.Data?) {
//
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//
//        dateLabel.text = "\(String(format: "%02d", data?.date ?? 0))일"
//
//        [overTime, nightTime, overNightTime].forEach { (label) in
//            setTimeText(label: label, data: data)
//        }
//
//        hourlyWageValue.text = "\(formatter.string(from: (data?.hourlyWage ?? 0) as NSNumber) ?? "0")원"
//        totalWorkValue.text = "\(data?.totalTime ?? "0 시간 0 분")"
//        dayPayValue.text = "\(formatter.string(from: (data?.totalPay ?? 0) as NSNumber) ?? "0")원"
//    }
}

//
//  PunchInView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/03.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import SnapKit
import Then


class PunchInView: BaseView {
    
    private let svMother = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    let btnDate = PunchInContainerButton().then {
        $0.setValue(
            title: "근무일:",
            rightValue: "1",
            rightUnit: "일"
        )
    }
    
    let btnWage = PunchInContainerButton().then {
        $0.setValue(
            title: "시급:",
            centerValue: "시급",
            centerUnit: "원"
        )
    }
    
    let btnWork = PunchInContainerButton().then {
        $0.setValue(
            title: "근무:",
            centerValue: "근무",
            centerUnit: "시간",
            rightValue: "근무",
            rightUnit: "분"
        )
    }
    
    let btnOver = PunchInContainerButton().then {
        $0.setValue(
            title: "특근:",
            centerValue: "근무",
            centerUnit: "시간",
            rightValue: "근무",
            rightUnit: "분"
        )
    }
    
    let btnNight = PunchInContainerButton().then {
        $0.setValue(
            title: "야근:",
            centerValue: "근무",
            centerUnit: "시간",
            rightValue: "근무",
            rightUnit: "분"
        )
    }
    
    let btnOverNight = PunchInContainerButton().then {
        $0.setValue(
            title: "야/특근:",
            centerValue: "근무",
            centerUnit: "시간",
            rightValue: "근무",
            rightUnit: "분"
        )
    }
    
    let btnTotal = PunchInContainerButton().then {
        $0.setValue(
            title: "총 근무:",
            centerValue: "0",
            centerUnit: "시간",
            rightValue: "0",
            rightUnit: "분"
        )
    }
    
    private let lblDayPay = UILabel().then {
        $0.text = "일 급여:"
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
    
    private let lblPreview = PaddingLabel(withInsets: 0, 0, 0, 15).then {
        $0.text = "0 원"
        $0.font = .setCustomFont(font: .bold, size: 20)
        $0.textAlignment = .right
        $0.backgroundColor = .setCustomColor(.lightGray)
        $0.clipsToBounds = true
        $0.borderColor = .setCustomColor(.yellow)
        $0.borderWidth = 2
        $0.cornerRadius = 25
    }
    
    let btnSave = PyoButton(type: .system).then {
        $0.setTitle("저장", for: .normal)
        $0.titleLabel?.font = .setCustomFont(font: .bold, size: 20)
        $0.cornerRadius = 25
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUP()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUP() {
        let views = [
            btnDate,
            btnWage, btnWork,
            btnOver, btnNight,
            btnOverNight, btnTotal,
            lblDayPay, lblPreview, btnSave
        ]
        
        svMother.addSubviews(views)
        
        self.addSubview(svMother)
    }
    
    private func setLayout() {
        svMother.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(self)
        }
        
        let buttons = [btnDate, btnWage, btnWork, btnOver, btnNight, btnOverNight, btnTotal]
        var previousBtn: PunchInContainerButton?
        
        buttons.enumerated().forEach { index, btn in
            if let previousBtn = previousBtn {
                btn.snp.makeConstraints { make in
                    make.top.equalTo(previousBtn.snp.bottom).offset(14)
                    make.left.right.equalTo(self).inset(15)
                    make.height.equalTo(previousBtn)
                }
            } else {
                btn.snp.makeConstraints { make in
                    make.top.equalTo(svMother).inset(10)
                    make.left.equalTo(self).inset(15)
                    make.right.equalTo(self.snp.centerX)
                    make.height.equalTo(btn.snp.width).multipliedBy(0.35)
                }
            }
            
            previousBtn = btn
        }
        
        btnSave.snp.makeConstraints { make in
            make.top.equalTo(btnTotal.snp.bottom).offset(15)
            make.right.equalTo(self).inset(15)
            make.width.equalTo(self).multipliedBy(0.16)
            make.height.equalTo(btnSave.snp.width)
            make.bottom.equalTo(svMother)
        }
        
        lblPreview.snp.makeConstraints { make in
            make.right.equalTo(btnSave.snp.left).offset(-5)
            make.height.centerY.equalTo(btnSave)
            make.width.equalTo(self).multipliedBy(0.325)
        }
        
        lblDayPay.snp.makeConstraints {
            $0.centerY.equalTo(lblPreview)
            $0.right.equalTo(lblPreview.snp.left).offset(-10)
        }
    }
    
    func setDateValue(_ date: Int) {
        btnDate.textColor(isEmpty: false)
        btnDate.setValue(rightValue: "\(date)")
    }
    
    func setWageValue(_ wage: Int) {
        let isZero = wage == 0
        let value = isZero ? "시급" : wage.comma
        
        btnWage.textColor(isEmpty: isZero)
        btnWage.setValue(centerValue: value)
    }
    
    func setTimeValue(type: PunchInVM.TimeType, data: WorkingTime) {
        let isZero = (data.hour == 0) && (data.min == 0)
        let hour = isZero ? "근무" : "\(data.hour)"
        let min = isZero ? "근무" : "\(data.min)"
        
        switch type {
        case .work:
            
            btnWork.textColor(isEmpty: isZero)
            btnWork.setValue(centerValue: hour, rightValue: min)
        case .over:
            
            btnOver.textColor(isEmpty: isZero)
            btnOver.setValue(centerValue: hour, rightValue: min)
        case .night:
            
            btnNight.textColor(isEmpty: isZero)
            btnNight.setValue(centerValue: hour, rightValue: min)
        case .overNight:
            
            btnOverNight.textColor(isEmpty: isZero)
            btnOverNight.setValue(centerValue: hour, rightValue: min)
        }
    }
    
    func setTotalValue(data: WorkingTime) {
        let isZero = (data.hour == 0) && (data.min == 0)
        
        btnTotal.textColor(isEmpty: isZero)
        btnTotal.setValue(centerValue: "\(data.hour)", rightValue: "\(data.min)")
    }
    
    func setDayPay(_ pay: Int) {
        lblPreview.text = pay.comma.won
    }
}

//
//  TimeCardView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/03/30.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import SnapKit
import Then


class TimeCardView: BaseView {
    
    private let lblTitle = UILabel().then {
        $0.attributedText = "이번 달엔 얼마나 받을까?".underLine
        $0.font = .setCustomFont(font: .black, size: 26)
    }
    
    let btnDate = UIButton(type: .system).then {
        $0.setTitleColor(.setCustomColor(.gray10), for: .normal)
        $0.titleLabel?.font = .setCustomFont(font: .black, size: 26)
    }
    
    let btnPrevious = UIButton(type: .system).then {
        let image = UIImage(systemName: "arrow.left")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    let btnNext = UIButton(type: .system).then {
        let image = UIImage(systemName: "arrow.right")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    let viewStatus = TimeCardStatusView().then {
        $0.cornerRadius = 25
    }
    
    private let viewEmpty = EmptyView().then {
        $0.setValue(explain: "근무 추가를 눌러서 급여\n관리를 시작해보세요:)")
    }
    
    let tvList = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset.bottom = 80
        $0.register(TimeCardCell.self, forCellReuseIdentifier: TimeCardCell.id)
    }
    
    let btnAdd = PyoButton(type: .system).then {
        $0.setTitle("근무 추가", for: .normal)
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
            lblTitle, btnDate, btnPrevious, btnNext,
            viewStatus, viewEmpty, tvList, btnAdd
        ]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints {
            $0.top.left.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        
        btnDate.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(lblTitle.snp.bottom).offset(15)
        }
        
        btnPrevious.snp.makeConstraints {
            $0.centerY.equalTo(btnDate)
            $0.left.equalTo(self).inset(15)
        }
        
        btnNext.snp.makeConstraints {
            $0.centerY.equalTo(btnDate)
            $0.right.equalTo(self).inset(15)
        }
        
        viewStatus.snp.makeConstraints {
            $0.top.equalTo(btnDate.snp.bottom).offset(30)
            $0.left.right.equalTo(self).inset(15)
        }
        
        viewEmpty.snp.makeConstraints {
            $0.edges.equalTo(tvList)
        }
        
        tvList.snp.makeConstraints {
            $0.top.equalTo(viewStatus.snp.bottom).offset(10)
            $0.left.right.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        btnAdd.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(0.26)
            $0.height.equalTo(btnAdd.snp.width).multipliedBy(0.5)
            $0.right.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
    }
    
    func setValue(_ value: (date: String, tax: TaxCase, totalPay: Int)) {
        btnDate.setTitle(value.date, for: .normal)
        viewStatus.setValue(wage: value.totalPay, tax: value.tax.rawValue)
    }
    
    func setHiddenEmpty(_ isHidden: Bool) {
        viewEmpty.isHidden = isHidden
    }
}

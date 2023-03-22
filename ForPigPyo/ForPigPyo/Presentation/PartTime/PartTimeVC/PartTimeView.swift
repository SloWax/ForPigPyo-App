//
//  PartTimeView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit
import Then


class PartTimeView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = "이번 달엔 얼마나 받을까?".underLine
        label.font = .setCustomFont(font: .black, size: 26)

        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .setCustomColor(.textBasic)
        label.font = .setCustomFont(font: .black, size: 26)
        
        return label
    }()
    let preButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    let nexButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        return button
    }()
    
    let containerView: ContainerView = {
        let view = ContainerView()
        view.label1.attributedText = "이번 달에는 얼마를 받을까요?".underLine
        view.label1.font = .setCustomFont(font: .bold, size: 14)
        
        view.label2.text = "총 급여: 0 원"
        view.label2.font = .setCustomFont(font: .bold, size: 20)
        
        return view
    }()
    let taxButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .setCustomColor(.textBasic)
        button.titleLabel?.font = .setCustomFont(font: .bold, size: 14)
        button.backgroundColor = .setCustomColor(.gray)
        button.layer.cornerRadius = Design.oneFifthCornerRadius
        
        return button
    }()
    
    let historyTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        return tableView
    }()
    let emptyView: EmptyView = {
        let view = EmptyView()
        view.setValue(explain: "근무 추가를 눌러서 급여\n관리를 시작해보세요:)")
        
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBackground
        button.setTitle("근무 추가", for: .normal)
        button.titleLabel?.font = .setCustomFont(font: .bold, size: 20)
        button.backgroundColor = .setCustomColor(.yellow)
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    private func setView() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.leading.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Design.largePadding)
        }
        
        self.addSubview(preButton)
        self.addSubview(nexButton)
        
        preButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalToSuperview().inset(Design.largePadding)
        }
        nexButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        self.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.equalTo(dateLabel.snp.bottom).offset(Design.padding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.label1.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.nomalPadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding)
        }
        
        containerView.label2.snp.makeConstraints {
            $0.top.equalTo(containerView.label1.snp.bottom).offset(Design.smallPadding)
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
            $0.bottom.equalToSuperview().inset(Design.nomalPadding)
        }
        
        containerView.addSubview(taxButton)
        
        taxButton.snp.makeConstraints {
            $0.top.equalTo(containerView.label1)
            $0.trailing.equalTo(containerView.label2)
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(taxButton.snp.width).multipliedBy(0.37)
        }
        
        self.addSubview(historyTable)
        
        historyTable.snp.makeConstraints {
            $0.top.equalTo(containerView.label2.snp.bottom).offset(Design.nomalPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.addSubview(emptyView)
        
        emptyView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(historyTable)
        }
        
        self.addSubview(addButton)
        
        addButton.snp.makeConstraints {
            
            $0.width.equalToSuperview().multipliedBy(0.26)
            $0.height.equalTo(addButton.snp.width).multipliedBy(0.5)
            $0.trailing.equalToSuperview().inset(Design.largePadding)
            $0.bottom.equalToSuperview().inset(Design.padding)
        }
    }
    
    func setValue(year: Int, month: Int, totalPay: String) {
        
        dateLabel.text = "\(year)년 \(month)월"
        containerView.label2.text = "총 급여: \(totalPay) 원"
    }
    func setButtonTitle(title: String) {
        
        taxButton.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class newPartTimeView: BaseView {
    
    private let lblTitle = UILabel().then {
        $0.attributedText = "이번 달엔 얼마나 받을까?".underLine
        $0.font = .setCustomFont(font: .black, size: 26)
    }
    
    private let lblDate = UILabel().then {
        $0.text = "test"
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .black, size: 26)
    }
    
    let btnPrevius = UIButton(type: .system).then {
        let image = UIImage(systemName: "arrow.left")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    let btnNext = UIButton(type: .system).then {
        let image = UIImage(systemName: "arrow.right")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    let viewStatus = StatusView()
    
    let tvList = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorColor = .clear
    }
    
    private let viewEmpty = EmptyView().then {
        $0.setValue(explain: "근무 추가를 눌러서 급여\n관리를 시작해보세요:)")
    }
    
    let btnAdd = UIButton(type: .system).then {
        $0.tintColor = .setCustomColor(.white)
        $0.setTitle("근무 추가", for: .normal)
        $0.titleLabel?.font = .setCustomFont(font: .bold, size: 20)
        $0.backgroundColor = .setCustomColor(.yellow)
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
        let views = [lblTitle, lblDate, btnPrevius, btnNext,
                     viewStatus, tvList, viewEmpty, btnAdd]
        
        self.addSubviews(views)
    }
    
    private func setLayout() {
        lblTitle.snp.makeConstraints {
            $0.top.left.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
        
        lblDate.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(lblTitle.snp.bottom).offset(15)
        }
        
        btnPrevius.snp.makeConstraints {
            $0.centerY.equalTo(lblDate)
            $0.left.equalTo(self).inset(15)
        }
        
        btnNext.snp.makeConstraints {
            $0.centerY.equalTo(lblDate)
            $0.right.equalTo(self).inset(15)
        }
        
        viewStatus.snp.makeConstraints {
            $0.top.equalTo(lblDate.snp.bottom).offset(30)
            $0.left.right.equalTo(self).inset(15)
        }
        
        tvList.snp.makeConstraints {
            $0.top.equalTo(viewStatus.snp.bottom).offset(10)
            $0.left.right.bottom.equalTo(self)
        }
        
        viewEmpty.snp.makeConstraints {
            $0.edges.equalTo(tvList)
        }
        
        btnAdd.snp.makeConstraints {
            $0.width.equalTo(self).multipliedBy(0.26)
            $0.height.equalTo(btnAdd.snp.width).multipliedBy(0.5)
            $0.right.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
        }
    }
    
    func setValue(year: Int, month: Int, totalPay: String) {
        
//        dateLabel.text = "\(year)년 \(month)월"
//        containerView.label2.text = "총 급여: \(totalPay) 원"
    }
    func setButtonTitle(title: String) {
        
//        taxButton.setTitle(title, for: .normal)
    }
}

class StatusView: UIView {
    
    private let lblTitle = UILabel().then {
        $0.attributedText = "이번 달에는 얼마를 받을까요?".underLine
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 14)
    }
    
    private let lblValue = UILabel().then {
        $0.text = "총 급여: 0 원"
        $0.textColor = .setCustomColor(.textBasic)
        $0.font = .setCustomFont(font: .bold, size: 20)
    }
        
    let btnTax = UIButton(type: .system).then {
        $0.tintColor = .setCustomColor(.textBasic)
        $0.titleLabel?.font = .setCustomFont(font: .bold, size: 14)
        $0.backgroundColor = .setCustomColor(.gray1)
        $0.layer.cornerRadius = 15
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = .setCustomColor(.lightGray)
        self.layer.cornerRadius = 15
        
        let views = [lblTitle, lblValue, btnTax]
        self.addSubviews(views)
        
        lblTitle.snp.makeConstraints {
            $0.top.left.equalTo(self).offset(15)
//            $0.leading.equalTo(self).inset(20)
        }
        
        btnTax.snp.makeConstraints {
            $0.centerY.equalTo(lblTitle)
            $0.right.equalTo(self).inset(15)
            $0.width.equalTo(self).multipliedBy(0.15)
            $0.height.equalTo(btnTax.snp.width).multipliedBy(0.37)
        }
        
        lblValue.snp.makeConstraints {
            $0.top.equalTo(lblTitle.snp.bottom).offset(5)
            $0.right.equalTo(btnTax)
            $0.bottom.equalTo(self).inset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TimeDataView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/18.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class TimeDataView: UIView {
    
    private let motherScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "xmark"), for: .normal)
        button.tintColor = .setCustomColor(.textBasic)
        
        return button
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.boldNomalTextSize
        
        return label
    }()
    
    let dateView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "근무일:"
        
        view.label2.text = "일"
        
        return view
    }()
    let hourlyWageView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "시급:"
        
        view.label2.text = "원"
        
        return view
    }()
    let workView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "근무:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    let overView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "특근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    let nightView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "야근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    let overNightView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "야/특근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    let totalView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "총 근무:"
        
        view.label2.text = "0 시간"
        
        view.label3.text = "0 분"
        
        return view
    }()
    lazy var allContainerView = [dateView, hourlyWageView, workView, overView, nightView, overNightView, totalView]
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "일 급여:"
        
        return label
    }()
    let previewLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Design.largePadding))
        label.text = "0 원"
        label.backgroundColor = .setCustomColor(.lightGray)
        label.layer.cornerRadius = Design.cornerRadius
        label.layer.borderColor = UIColor.setCustomColor(.yellow).cgColor
        label.layer.borderWidth = 2
        label.clipsToBounds = true
        label.textAlignment = .right
        
        return label
    }()
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.layer.cornerRadius = Design.cornerRadius
        button.backgroundColor = .setCustomColor(.yellow)
        button.tintColor = .systemBackground
        
        return button
    }()
    
    var constraint: Constraint?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setView()
        
        setContainerView()
        setLabel()
        setTextField()
        
        setTotal()
    }
    
    private func setView() {
        
        self.addSubview(motherScrollView)
        
        motherScrollView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        motherScrollView.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints {
            
            $0.top.equalTo(motherScrollView).inset(Design.smallPadding)
            $0.leading.equalToSuperview().inset(Design.largePadding)
            $0.width.equalToSuperview().multipliedBy(0.06)
            $0.height.equalTo(dismissButton.snp.width).multipliedBy(1.3)
        }
        
        motherScrollView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.equalTo(dismissButton)
            $0.leading.equalTo(dismissButton.snp.trailing).offset(Design.nomalPadding)
        }
    }
    private func setContainerView() {
        
        allContainerView.forEach { motherScrollView.addSubview($0) }
        
        dateView.snp.makeConstraints {
            
            $0.top.equalTo(dismissButton.snp.bottom).offset(Design.largestPadding)
            $0.leading.equalToSuperview().inset(Design.largePadding)
            $0.trailing.equalTo(self.snp.centerX)
            $0.height.equalTo(dateView.snp.width).multipliedBy(0.35)
        }
        
        hourlyWageView.snp.makeConstraints {
            
            $0.top.equalTo(dateView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(dateView.snp.height)
        }

        workView.snp.makeConstraints {
            
            $0.top.equalTo(hourlyWageView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(hourlyWageView.snp.height)
        }

        overView.snp.makeConstraints {
            
            $0.top.equalTo(workView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(workView.snp.height)
        }

        nightView.snp.makeConstraints {
            
            $0.top.equalTo(overView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(overView.snp.height)
        }

        overNightView.snp.makeConstraints {
            
            $0.top.equalTo(nightView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(nightView.snp.height)
        }
        
        totalView.snp.makeConstraints {
            
            $0.top.equalTo(overNightView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(overNightView.snp.height)
        }
    }
    private func setLabel() {
        
        allContainerView.forEach { (containerView) in
            containerView.labelBundle.forEach { (label) in
                
                label.font = Design.boldNomalTextSize
            }
        }
        
        dateView.label1.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(Design.largePadding)
                $0.width.equalToSuperview().multipliedBy(0.41)
            }
        
        dateView.label2.snp.makeConstraints {
            
            $0.centerY.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.22)
        }
        
        let labels1and2 = [hourlyWageView, workView, overView, nightView]
        
        labels1and2.forEach {
            $0.label1.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(dateView.label1)
                $0.width.equalTo(dateView.label1).multipliedBy(0.7)
            }
            
            $0.label2.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.leading.trailing.equalTo(dateView.label2)
            }
        }
        
        overNightView.label1.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalTo(dateView.label1)
        }
        
        overNightView.label2.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalTo(dateView.label2)
        }
        
        let labels3 = [workView, overView, nightView, overNightView]
        
        labels3.forEach {
            $0.label3.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().multipliedBy(0.75)
                $0.width.equalToSuperview().multipliedBy(0.05)
            }
        }
        
        totalView.label1.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(dateView.label1)
        }
        
        totalView.label2.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(workView.label2)
        }
        
        totalView.label3.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(workView.label3)
        }
    }
    private func setTextField() {
        
        let textField1 = [dateView, hourlyWageView, workView, overView, nightView, overNightView]
        
        textField1.forEach { (containerView) in
            
            containerView.textField1.snp.makeConstraints {
                
                $0.centerY.equalTo(containerView.label1)
                $0.leading.equalTo(containerView.label1.snp.trailing)
                $0.trailing.equalTo(containerView.label2.snp.leading).offset(-Design.smallPadding)
            }
            
            let attributes: [NSAttributedString.Key: Any?] = [
                .foregroundColor: UIColor.setCustomColor(.textBasic, alpha: 0.5),
                .font: Design.nomalTextSize
            ]
            
            if containerView == hourlyWageView {
                
                containerView.textField1.attributedPlaceholder = NSAttributedString(string: "시급", attributes: attributes as [NSAttributedString.Key: Any])
            } else {
                
                containerView.textFieldBundle.forEach { (textField) in
                    
                    textField.attributedPlaceholder = NSAttributedString(string: "근무", attributes: attributes as [NSAttributedString.Key: Any])
                }
            }
        }
        
        let textField2 = [workView, overView, nightView, overNightView]
        
        textField2.forEach { (containerView) in
            
            containerView.textField2.snp.makeConstraints {
                
                $0.centerY.equalTo(containerView.label2)
                $0.leading.equalTo(containerView.label2.snp.trailing)
                $0.trailing.equalTo(containerView.label3.snp.leading).offset(-Design.smallPadding)
            }
        }
    }
    private func setTotal() {
        
        motherScrollView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            
            $0.top.equalTo(totalView.snp.bottom).offset(Design.largePadding)
            $0.trailing.equalTo(self).inset(Design.nomalPadding + Design.largePadding)
            $0.width.equalTo(self).multipliedBy(0.16)
            $0.height.equalTo(saveButton.snp.width)
            constraint = $0.bottom.equalToSuperview().inset(55).constraint
        }
        
        [totalLabel, previewLabel].forEach {
            
            $0.font = Design.boldNomalTextSize
            motherScrollView.addSubview($0)
        }
        
        previewLabel.snp.makeConstraints {
            
            $0.trailing.equalTo(saveButton.snp.leading).offset(-Design.smallPadding)
            $0.height.centerY.equalTo(saveButton)
            $0.width.equalTo(self).multipliedBy(0.325)
        }
        
        totalLabel.snp.makeConstraints {
            
            $0.centerY.equalTo(previewLabel)
            $0.trailing.equalTo(previewLabel.snp.leading).offset(-Design.nomalPadding)
        }
    }
    
    func setValue(title: String, date: String?, hourly: String?, workHour: String?, workMin: String?, saveIndex: Int, value: PayList.Year.Month.Data?) {
        
        titleLabel.attributedText = title.underLine
        
        if let value = value {
            
            titleLabel.tag = saveIndex
            
            dateView.textField1.text = "\(value.date)"
            hourlyWageView.textField1.text = "\(value.hourlyWage)"
            
            workView.textField1.text = "\(value.workingTime)"
            workView.textField2.text = "\(value.workingTimeMin)"
            
            overView.textField1.text = "\(value.overTime)"
            overView.textField2.text = "\(value.overTimeMin)"
            
            nightView.textField1.text = "\(value.nightTime)"
            nightView.textField2.text = "\(value.nightTimeMin)"
            
            overNightView.textField1.text = "\(value.overNightTime)"
            overNightView.textField2.text = "\(value.overNightTimeMin)"
            
            totalView.label2.text = "\(value.totalTime.convertTime[0]) 시간"
            totalView.label3.text = "\(value.totalTime.convertTime[1]) 분"
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            previewLabel.text = "\(formatter.string(from: value.totalPay as NSNumber) ?? "0") 원"
            
            return
        }
        
        dateView.textField1.text = date
        hourlyWageView.textField1.text = hourly
        workView.textField1.text = workHour
        workView.textField2.text = workMin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

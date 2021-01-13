//
//  TimeDataView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/18.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class TimeDataView: UIView {
    
    private let motherScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let dateView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "근무일:"
        
        view.label2.text = "일"
        
        return view
    }()
    private let hourlyWageView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "시급:"
        
        view.label2.text = "원"
        
        return view
    }()
    private let workView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "근무:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    private let nightView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "야근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    private let overView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "특근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    private let overNightView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "야/특근:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    private let totalView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "근무:"
        
        view.label2.text = "시간"
        
        view.label3.text = "분"
        
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setView()
        setLabel()
    }
    private func setView() {
        
        self.addSubview(motherScrollView)
        
        motherScrollView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        [dateView, hourlyWageView, workView, nightView, overView, overNightView, totalView].forEach { (containerView) in

            containerView.labelBundle.forEach {
                $0.font = Design.boldNomalTextSize
            }
            motherScrollView.addSubview(containerView)
        }
        
        dateView.snp.makeConstraints {

            $0.top.equalToSuperview().offset(Design.padding)
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

        nightView.snp.makeConstraints {

            $0.top.equalTo(workView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(workView.snp.height)
        }

        overView.snp.makeConstraints {

            $0.top.equalTo(nightView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(nightView.snp.height)
        }

        overNightView.snp.makeConstraints {

            $0.top.equalTo(overView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(overView.snp.height)
        }

        totalView.snp.makeConstraints {

            $0.top.equalTo(overNightView.snp.bottom).offset(Design.largePadding)
            $0.leading.trailing.equalTo(self).inset(Design.largePadding)
            $0.height.equalTo(overNightView.snp.height)
            $0.bottom.equalToSuperview()
        }
    }
    private func setLabel() {
        
        let view = [dateView, hourlyWageView, workView, nightView, overView, overNightView, totalView]
        
        view.forEach({
            $0.label1.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(Design.largePadding)
            }
        })
        
        view.forEach {
            $0.label2.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(dateView.label1)
            }
        }
        
        view.forEach {
            $0.label3.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TimeCardVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/03/30.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional


class TimeCardVC: BaseMainVC {
    private let timeCardView = TimeCardView()
    private var vm: TimeCardVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> TimeCardVM {
        let inputs = TimeCardVM()
        
        return inputs
    }
    
    private func initialize() {
        vm = setInputs()
        
        view = timeCardView
    }
    
    private func bind() {
        self.rx
            .viewWillAppear
            .bind(to: vm.input.bindRefresh)
            .disposed(by: vm.bag)
        
        timeCardView.btnDate // 현재로 돌아오기
            .rx
            .tap
            .map { 0 }
            .bind(to: vm.input.bindMove)
            .disposed(by: vm.bag)
        
        timeCardView.btnPrevious // 이전달
            .rx
            .tap
            .map { -1 }
            .bind(to: vm.input.bindMove)
            .disposed(by: vm.bag)
        
        timeCardView.btnNext // 다음달
            .rx
            .tap
            .map { 1 }
            .bind(to: vm.input.bindMove)
            .disposed(by: vm.bag)
        
        timeCardView.btnAdd // 근무기록 추가
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                let punchInVC = PunchInVC(type: .create)
                self.pushVC(punchInVC)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindValue // 날짜, 임금 값 전달
            .bind { [weak self] value in
                guard let self = self else { return }
                
                self.timeCardView.setValue(value)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindList // 근무 기록 리스트
            .bind(to: timeCardView.tvList
                .rx
                .items(cellIdentifier: TimeCardCell.id,
                       cellType: TimeCardCell.self)
            ) { (row, data, cell) in
                
//                cell.setValue(data)
            }.disposed(by: vm.bag)
        
        vm.output
            .bindList // viewEmpty isHidden
            .bind { [weak self] list in
                guard let self = self else { return }
                
                let isHidden = !list.isEmpty
                self.timeCardView.setHiddenEmpty(isHidden)
            }.disposed(by: vm.bag)
    }
}

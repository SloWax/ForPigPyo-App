//
//  PartTimeVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/05.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class PartTimeVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        
        return imageView
    }()
    lazy var partTimeView: PartTimeView = {
        let view = PartTimeView()
        view.historyTable.delegate = self
        view.historyTable.dataSource = self
        view.historyTable.register(PartTimeCustomCell.self, forCellReuseIdentifier: PartTimeCustomCell.identifier)
        
        return view
    }()
    let saveView: PartTimeSaveView = {
        let view = PartTimeSaveView()
        
        return view
    }()
    
    let model = PartTimeVCModel()
    var data = PayList(month: [PayList.Month(data: [
                                                PayList.Month.Data(date: "13", workingTime: 10, overWorkingTime: 1, nightWorkTime: 1, overNightWorkTime: 1, hourlyWage: 5000, totalPay: 12500),
                                                PayList.Month.Data(date: "12", workingTime: 10, overWorkingTime: 1, nightWorkTime: 1, overNightWorkTime: 1, hourlyWage: 5000, totalPay: 12500)]
    )])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setPartTimeView()
        setSaveView()
    }
    private func setView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setPartTimeView() {
        
        partTimeView.totalLabel.text = "총 \(model.setTotalPay(data: data)) 원"
        view.addSubview(partTimeView)
        
        partTimeView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setSaveView() {
        
        view.addSubview(saveView)
        
        saveView.snp.makeConstraints {
            $0.top.equalTo(partTimeView.totalLabel)
            $0.width.equalToSuperview().multipliedBy(0.83)
            
            $0.trailing.equalToSuperview()
        }
    }
}

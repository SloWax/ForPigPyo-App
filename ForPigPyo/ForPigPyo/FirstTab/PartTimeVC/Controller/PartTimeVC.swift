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
    
    let data = PayList(month: [PayList.Month(data: [PayList.Month.Data(date: "12일", workingTime: 1, overWorkingTime: 1, hourlyWage: 5000, totalPay: 12500)])])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setPartTimeView()
    }
    private func setView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setPartTimeView() {
        
        view.addSubview(partTimeView)
        
        partTimeView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

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
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        
        return imageView
    }()
    private lazy var partTimeView: PartTimeView = {
        let view = PartTimeView()
        view.historyTable.delegate = self
        view.historyTable.dataSource = self
        view.historyTable.register(PartTimeCustomCell.self, forCellReuseIdentifier: PartTimeCustomCell.identifier)
        
        return view
    }()
    private let saveView: PartTimeSaveView = {
        let view = PartTimeSaveView()
        
        return view
    }()
    private var constraint: Constraint?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addSaveView(_:)))
        
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
        
        [saveView.cancleButton, saveView.saveButton].forEach({ (button) in
            button.addTarget(self, action: #selector(returnSaveView(_:)), for: .touchUpInside)
        })
        view.addSubview(saveView)
        
        saveView.snp.makeConstraints {
            $0.top.equalTo(partTimeView.totalLabel)
            $0.width.equalToSuperview()
            constraint = $0.leading.equalTo(view.snp.trailing).constraint
        }
    }
    private func moveSaveView(offset: CGFloat) {
        
        UIView.animate(withDuration: 0.25) {
            
            self.constraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
    }
    func loadSaveView(isAdd: Bool, index: IndexPath?, title: String) {
        if isAdd == true {
            
            saveView.setValue(title: title, isAdd: isAdd, value: nil)
        } else {
            
            saveView.setValue(title: title, isAdd: isAdd, value: data.month[0].data[index?.row ?? 0])
        }
        
        moveSaveView(offset: -view.frame.width)
    }
    @objc private func addSaveView(_ sender: UIButton) {
        
        loadSaveView(isAdd: true, index: nil, title: "추가하기")
    }
    @objc private func returnSaveView(_ sender: UIButton) {
        
        if sender.tag == 1 {
            print("save")
            let division = saveView.titleLabel.text
            model.saveData(division: division ?? "")
        }
        
        moveSaveView(offset: 0)
    }
}

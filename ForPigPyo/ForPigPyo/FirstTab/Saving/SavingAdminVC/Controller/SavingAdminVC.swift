//
//  SavingAdminVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingAdminVC: UIViewController {
    
    lazy var savingAdminView: SavingAdminView = {
        let view = SavingAdminView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(SavingAdminCustomCell.self, forCellReuseIdentifier: SavingAdminCustomCell.identifier)
        
        view.addButton.addTarget(self, action: #selector(AddButton(_:)), for: .touchUpInside)
        
        return view
    }()
    
    let model = SavingVCModel()
    var data: SavingList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        reloadData(data: data)
    }
    
    private func setView() {
        
        let backBarButtonItem = UIBarButtonItem(title: "저축액 관리하기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(savingAdminView)
        
        savingAdminView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func reloadData(data: SavingList?) {
        
        savingAdminView.setValue(allSave: model.untilSavingCalcu(list: data))
        savingAdminView.tableView.reloadData()
    }
    func pushAddSavingVC(isEdit: Bool, saveIndex: Int) {
        
        let addSavingVC = AddSavingVC()
        let savingView = addSavingVC.savingAddEditView
        
        addSavingVC.data = data
        savingView.titleLabel.tag = saveIndex
        
        switch isEdit {
        case false:
            
            savingView.titleLabel.attributedText = "저축 추가하기".underLine
            addSavingVC.setDate(date: Date())
        case true:
            
            let formatter: DateFormatter = {
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM"
                
                return format
            }()
            if let dataIndex = data?.data[saveIndex] {
             
                let dateString = "\(dataIndex.year)-\(dataIndex.month)"
                let date = formatter.date(from: dateString) ?? Date()
                
                savingView.titleLabel.attributedText = "저축 수정하기".underLine
                addSavingVC.setDate(date: date)
                savingView.saveSumView.textField1.text = "\(dataIndex.saving)"
            }
        }
        
        navigationController?.pushViewController(addSavingVC, animated: true)
    }
    
    @objc private func AddButton(_ sender: UIButton) {
        
        pushAddSavingVC(isEdit: false, saveIndex: 0)
    }
}

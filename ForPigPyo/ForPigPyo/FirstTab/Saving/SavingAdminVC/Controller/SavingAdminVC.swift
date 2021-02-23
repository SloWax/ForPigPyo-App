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
        
        view.addButton.addTarget(self, action: #selector(addButton(_:)), for: .touchUpInside)
        
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
    
    @objc private func addButton(_ sender: UIButton) {
        
        pushAddSavingVC(isEdit: false, saveIndex: 0)
    }
}

extension SavingAdminVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dataCount = data?.data.count ?? 0
        
        if dataCount == 0 {
            savingAdminView.emptyView.isHidden = false
        } else {
            savingAdminView.emptyView.isHidden = true
        }
        
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavingAdminCustomCell.identifier, for: indexPath) as? SavingAdminCustomCell else { fatalError() }
        cell.setValue(data: data?.data[indexPath.row])
        
        return cell
    }
}

extension SavingAdminVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // tableView cell 슬라이딩 delete
        switch editingStyle {
        case .delete:
            
            data?.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            reloadData(data: data)
            model.saveData(data: data ?? SavingList(aimSaving: 0, aimDate: "", data: [SavingList.Data]()))
            
            if let savingVC = self.navigationController?.viewControllers[1] as? SavingVC {
                
                savingVC.data = data
                savingVC.reloadData(data: savingVC.data)
            }
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushAddSavingVC(isEdit: true, saveIndex: indexPath.row)
    }
}

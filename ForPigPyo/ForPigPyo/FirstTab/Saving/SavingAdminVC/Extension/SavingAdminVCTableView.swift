//
//  SavingAdminVCTableView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

extension SavingAdminVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data?.data.count ?? 0
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

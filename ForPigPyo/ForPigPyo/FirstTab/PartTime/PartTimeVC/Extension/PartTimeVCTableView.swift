//
//  PartTimeVCTableView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension PartTimeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dataCount = data?.years[yearIndex].months[monthIndex].data.count ?? 0
        
        if dataCount == 0 {
            partTimeView.emptyView.isHidden = false
        } else {
            partTimeView.emptyView.isHidden = true
        }
        
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartTimeCustomCell.identifier, for: indexPath) as? PartTimeCustomCell else { fatalError() }
        cell.setValue(data: data?.years[yearIndex].months[monthIndex].data[indexPath.row])
        
        return cell
    }
}

extension PartTimeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // tableView cell delete
        switch editingStyle {
        case .delete:
            
            data?.years[yearIndex].months[monthIndex].data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            loadPartTimeValue(deduction: taxIndex % tax.count)
            model.saveData(data: data ?? PayList(years: [PayList.Year]()))
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presentTimeDataVC(isAdd: false, saveIndex: indexPath.row)
    }
}

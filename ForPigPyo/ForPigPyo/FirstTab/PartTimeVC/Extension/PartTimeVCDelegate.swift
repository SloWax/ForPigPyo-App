//
//  PartTimeVCDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension PartTimeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            data?.years[yearIndex].months[monthIndex].data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            loadPartTimeValue(deduction: deductionIndex % partTimeView.deduction.count)
            model.saveData(data: data ?? PayList(years: [PayList.Year]()))
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadSaveView(isAdd: false, yearIndex: yearIndex, monthIndex: monthIndex, index: indexPath.row, title: "수정하기")
    }
    
}

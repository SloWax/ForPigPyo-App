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
            
            data?.year[0].month[0].data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            partTimeView.totalLabel.text = "총 \(model.setTotalPay(data: data)) 원"
            
            model.saveData(data: data ?? PayList(year: [PayList.Years(year: 0, month: [PayList.Years.Month(month: 1, data: [PayList.Years.Month.Data]())])]))
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadSaveView(isAdd: false, index: indexPath.row, title: "수정하기")
    }
    
}

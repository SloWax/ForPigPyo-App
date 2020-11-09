//
//  PartTimeVCDataSource.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension PartTimeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.month[0].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartTimeCustomCell.identifier, for: indexPath) as? PartTimeCustomCell else { fatalError() }
        let value = data.month[0].data[indexPath.row]
        
        cell.setValue(date: value.date,
                      work: value.workingTime,
                      over: value.overWorkingTime,
                      hourly: value.hourlyWage,
                      total: value.totalPay)
        
        return cell
    }
}

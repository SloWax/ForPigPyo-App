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
        data?.month[0].data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartTimeCustomCell.identifier, for: indexPath) as? PartTimeCustomCell else { fatalError() }
        let value = data?.month[0].data[indexPath.row]
        
        cell.setValue(date: value?.date ?? "",
                      over: value?.overWorkingTime ?? 0,
                      nightWork: value?.nightWorkTime ?? 0,
                      overNight: value?.overNightWorkTime ?? 0,
                      hourly: value?.hourlyWage ?? 0,
                      totalWork: value?.workingTime ?? 0,
                      dayPay: Int(value?.totalPay ?? 0))
        
        return cell
    }
}
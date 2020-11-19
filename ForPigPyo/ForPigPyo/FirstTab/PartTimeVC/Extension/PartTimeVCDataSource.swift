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
        
        return data?.year[0].month[0].data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartTimeCustomCell.identifier, for: indexPath) as? PartTimeCustomCell else { fatalError() }
        cell.setValue(data: data?.year[0].month[0].data[indexPath.row])
        
        return cell
    }
}

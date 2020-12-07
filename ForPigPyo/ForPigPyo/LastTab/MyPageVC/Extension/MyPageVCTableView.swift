//
//  MyPageVCTableView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension MyPageVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return menuData.menu.count - 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageHeaderCustomSection.identifier) as? MyPageHeaderCustomSection else { fatalError() }
        header.setValue(title: menuData.menu[section].title)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuData.menu[section].myPageMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCustomCell.identifier, for: indexPath) as? MyPageCustomCell else { fatalError() }
        let sectionIV = menuData.menu[indexPath.section]
        cell.setValue(image: sectionIV.image,
                      title: sectionIV.myPageMenu[indexPath.row])
        
        return cell
    }
}

extension MyPageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MyPageCustomCell else { fatalError() }
        
    }
}

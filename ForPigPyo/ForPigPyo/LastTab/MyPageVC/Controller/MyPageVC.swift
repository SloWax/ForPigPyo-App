//
//  MyPageVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.purple
        
        return imageView
    }()
    lazy var myPageTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyPageCustomCell.self, forCellReuseIdentifier: MyPageCustomCell.identifier)
        tableView.register(MyPageHeaderCustomSection.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderCustomSection.identifier)
        
        
        return tableView
    }()
    
    var menuData: HomeVCModel = HomeVCModel(menu: [HomeVCModel.Menu]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setMyPageTable()
    }
    private func setView() {
        
        navigationItem.title = "My Page"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Design.LargeTextSize ?? UIFont()]
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setMyPageTable() {
        
        view.addSubview(myPageTable)
        
        myPageTable.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//
//  SavingAdminVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingAdminVC: UIViewController {
    
    private lazy var savingAdminView: SavingAdminView = {
        let view = SavingAdminView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(SavingAdminCustomCell.self, forCellReuseIdentifier: SavingAdminCustomCell.identifier)
        
        view.addButton.addTarget(self, action: #selector(pushAddSavingVC(_:)), for: .touchUpInside)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
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
    
    @objc private func pushAddSavingVC(_ sender: UIButton) {
        let addSavingVC = AddSavingVC()
        
        navigationController?.pushViewController(addSavingVC, animated: true)
    }
}

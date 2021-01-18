//
//  SavingVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingVC: UIViewController {
    
    let savingView: SavingView = {
        let view = SavingView()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    
    private func setView() {
        
        let backBarButtonItem = UIBarButtonItem(title: savingView.titleLabel.text, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        view.backgroundColor = .systemBackground
        
        savingView.setAimButton.addTarget(self, action: #selector(pushSetAimVC(_:)), for: .touchUpInside)
        savingView.savingAdminButton.addTarget(self, action: #selector(pushSavingAdminVC(_:)), for: .touchUpInside)
        view.addSubview(savingView)
        
        savingView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func pushSetAimVC(_ sender: UIButton) {
        let setAimVC = SetAimVC()
        
        navigationController?.pushViewController(setAimVC, animated: true)
    }
    @objc private func pushSavingAdminVC(_ sender: UIButton) {
        let savingAdminVC = SavingAdminVC()
        
        navigationController?.pushViewController(savingAdminVC, animated: true)
    }
}

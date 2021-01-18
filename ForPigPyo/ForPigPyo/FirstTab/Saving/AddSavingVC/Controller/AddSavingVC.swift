//
//  AddSavingVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class AddSavingVC: UIViewController {
    
    private let savingAddEditView: SavingAddEditView = {
        let view = SavingAddEditView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    private func setView() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(savingAddEditView)
        
        savingAddEditView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

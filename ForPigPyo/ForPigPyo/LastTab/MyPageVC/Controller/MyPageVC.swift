//
//  MyPageVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

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
    lazy var taxPickerView: DonePickerView = {
    let picker = DonePickerView()
    picker.pickerView.dataSource = self
    picker.pickerView.delegate = self
    
    return picker
}()
    
    let model = MyPageVCModel()
    var menuData: HomeVCModel = HomeVCModel(menu: [HomeVCModel.Menu]())
    var constraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setMyPageTable()
        setTaxPickerView()
    }
    // set View
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
    private func setTaxPickerView() {
        
        taxPickerView.doneButton.action = #selector(taxPickerDone(_:))
        view.addSubview(taxPickerView)
        
        taxPickerView.snp.makeConstraints {
            
            constraint = $0.top.equalTo(view.snp_bottomMargin).constraint
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func moveTaxPicker(offset: CGFloat) {
        // pickerView animation
        UIView.animate(withDuration: 0.25) {
            
            self.constraint?.update(offset: offset)
            self.view.layoutIfNeeded()
        }
        myPageTable.reloadData()
    }
    
    @objc private func taxPickerDone(_ sender: UIBarButtonItem) {
        // picker doneButton Action
        moveTaxPicker(offset: 0)
        taxPickerView.pickerView.selectRow(0, inComponent: 0, animated: true)
    }
}

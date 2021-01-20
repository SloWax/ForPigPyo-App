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
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    lazy var myPageView: MyPageView = {
        let view = MyPageView()
        
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.register(MyPageCustomCell.self, forCellReuseIdentifier: MyPageCustomCell.identifier)
        view.tableView.register(MyPageHeaderCustomSection.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderCustomSection.identifier)
        
        
        return view
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let partVC = tabBarController?.viewControllers?[0].children.last as? PartTimeVC {
            
            taxPickerView.pickerView.selectRow((partVC.taxIndex % partVC.tax.count) + 1, inComponent: 0, animated: true)
            myPageView.tableView.reloadData()
        }
    }
    // set View
    private func setView() {
        
        navigationItem.title = "마이 페이지"
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(myPageView)
        
        myPageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
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
        myPageView.tableView.reloadData()
    }
    @objc func textCountLimit(_ sender: UITextField) {
        
        guard sender.text?.count ?? 0 < 3  else { return sender.deleteBackward() }
    }
    @objc private func taxPickerDone(_ sender: UIBarButtonItem) {
        // picker doneButton Action
        moveTaxPicker(offset: 0)
    }
}

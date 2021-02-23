//
//  SavingVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class SavingVC: UIViewController {
    
    static let forkey: String = "SavingVC"
    
    let savingView: SavingView = {
        let view = SavingView()
        
        return view
    }()
    
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        return format
    }()
    let model = SavingVCModel()
    var data: SavingList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setView()
    }
    
    private func loadData() {
        
        data = model.loadData() ?? SavingList(aimSaving: 0, aimDate: formatter.string(from: Date()), data: [SavingList.Data]())
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
        
        reloadData(data: data)
    }
    func reloadData(data: SavingList?) {
        
        let aimSaving = data?.aimSaving ?? 0
        let untilSaving = model.untilSavingCalcu(list: data)
        let untilDay = model.untilDayCalcu(list: data)
        let thisMonthSave = model.thisMonthSaveCalcu(list: data)
        
        savingView.setValue(aimSaving: aimSaving, untilSaving: untilSaving, untilDay: untilDay, thisMonthSave: thisMonthSave)
    }
    func backupToDB() {
        let firestore = Firestore.firestore()
        
        if let userID = UserDefaults.standard.string(forKey: LoginVC.userID) {
            do {
                try firestore.collection(userID).document(SavingVC.forkey).setData(from: data)
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    @objc private func pushSetAimVC(_ sender: UIButton) {
        let setAimVC = SetAimVC()
        
        let myAimText = setAimVC.setAimView.myAimView.textField1
        data?.aimSaving == 0 ? (myAimText.text = nil) : (myAimText.text = "\(data?.aimSaving ?? 0)")
        
        let date = formatter.date(from: data?.aimDate ?? "") ?? Date()
        setAimVC.setDate(date: date)
        
        navigationController?.pushViewController(setAimVC, animated: true)
    }
    @objc private func pushSavingAdminVC(_ sender: UIButton) {
        let savingAdminVC = SavingAdminVC()
        
        savingAdminVC.data = data
        
        navigationController?.pushViewController(savingAdminVC, animated: true)
    }
}

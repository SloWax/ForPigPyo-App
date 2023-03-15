//
//  LoginVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/03/01.
//  Copyright © 2021 SloWax. All rights reserved.
//

import Foundation
import Firebase

struct LoginVCModel {
    func loadFromDB() {
        let firestore = Firestore.firestore()
        
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            let partTimeDoc = firestore.collection(userID).document(PartTimeVC.forkey)
            let savingDoc = firestore.collection(userID).document(SavingVC.forkey)
            
            [partTimeDoc, savingDoc].forEach { (doc) in
                switch doc {
                case partTimeDoc:
                    doc.getDocument { (document, _ ) in
                        let result = Result {
                            try document?.data(as: PayList.self)
                        }
                        switch result {
                        case .success(let data):
                            if let data = data {
                                
                                PartTimeVCModel().saveData(data: data)
                            } else {
                                break
                            }
                        case .failure:
                            break
                        }
                    }
                case savingDoc:
                    doc.getDocument { (document, _ ) in
                        let result = Result {
                            try document?.data(as: SavingList.self)
                        }
                        switch result {
                        case .success(let data):
                            if let data = data {
                                
                                SavingVCModel().saveData(data: data)
                            } else {
                                break
                            }
                        case .failure:
                            break
                        }
                    }
                default:
                    fatalError()
                }
            }
        }
    }
}

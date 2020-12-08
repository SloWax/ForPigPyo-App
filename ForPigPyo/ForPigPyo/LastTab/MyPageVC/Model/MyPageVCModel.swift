//
//  MyPageVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct MyPageVCModel {
    
    func saveHourly(data: String, forKey: String) {
        
        guard data != "" else { return setUserDefaults(data: nil, forKey: forKey) }
        
        if let value = Int(data) {
            guard value != 0 else { return setUserDefaults(data: nil, forKey: forKey) }
            
            setUserDefaults(data: String(value), forKey: forKey)
        }
    }
    func saveTax(data: String, forKey: String) {
        
        guard data != "미공제" else { return setUserDefaults(data: nil, forKey: forKey) }
            
        setUserDefaults(data: data, forKey: forKey)
    }
    func loadData(forKey: String) -> String? {
        
        return UserDefaults.standard.string(forKey: forKey)
    }
    private func setUserDefaults(data: String?, forKey: String) {
        
        UserDefaults.standard.set(data, forKey: forKey)
    }
}

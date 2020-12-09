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
        
        guard data != "" else { return saveHourlyDefaults(data: nil, forKey: forKey) }
        
        if let value = Int(data) {
            guard value != 0 else { return saveHourlyDefaults(data: nil, forKey: forKey) }
            
            saveHourlyDefaults(data: String(value), forKey: forKey)
        }
    }
    func saveTax(data: Int?, forKey: String) {
            
        UserDefaults.standard.set(data, forKey: forKey)
    }
    func loadHourly(forKey: String) -> String? {
        
        return UserDefaults.standard.string(forKey: forKey)
    }
    func loadTax(forKey: String) -> Int? {
        
        return UserDefaults.standard.object(forKey: forKey) as? Int
    }
    private func saveHourlyDefaults(data: String?, forKey: String) {
        
        UserDefaults.standard.set(data, forKey: forKey)
    }
}

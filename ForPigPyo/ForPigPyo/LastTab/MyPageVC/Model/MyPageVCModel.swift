//
//  MyPageVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation

struct MyPageVCModel {
    
    // MARK: 시급 설정
    
    func saveHourly(data: String, forKey: String) {
        
        guard data != "" else { return saveHourlyDefaults(data: nil, forKey: forKey) }
        
        if let value = Int(data) {
            guard value != 0 else { return saveHourlyDefaults(data: nil, forKey: forKey) }
            
            saveHourlyDefaults(data: String(value), forKey: forKey)
        }
    }
    
    // MARK: 세금 설정
    
    func saveTax(data: Int?, forKey: String) {
     // 세금 index 저장
        UserDefaults.standard.set(data, forKey: forKey)
    }
    
    // MARK: MyPage에서 저장한 정보 load
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

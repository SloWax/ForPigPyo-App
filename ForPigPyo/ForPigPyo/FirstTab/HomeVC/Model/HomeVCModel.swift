//
//  HomeVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/28.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation


struct HomeVCModel {
    
    func saveBackImage(data: Data?, forkey: String) {
        
        UserDefaults.standard.set(data, forKey: forkey)
    }
    
    func loadBackImage(forkey: String) -> Data? {
        
        return UserDefaults.standard.object(forKey: forkey) as? Data
    }
}

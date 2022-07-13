//
//  SavingList.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import Foundation

struct SavingList: Codable {
    
    var aimSaving: Int
    var aimDate: String
    
    var data: [Data]
    
    struct Data: Codable {
        
        let year: String
        let month: String
        
        let saving: Int
    }
}

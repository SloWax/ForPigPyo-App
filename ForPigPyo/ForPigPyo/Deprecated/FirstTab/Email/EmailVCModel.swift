//
//  EmailVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation


enum SDKIdentifier {
    case adMobfull
    case adMobBanner
    
    
    var key: String? {
        #if DEBUG
        let key = Bundle.main.object(forInfoDictionaryKey: "\(self.rawValue)Debug")
        #else
        let key = Bundle.main.object(forInfoDictionaryKey: self.rawValue)
        #endif
        
        guard let key = key as? String else { return "nil"}
        
        return key
    }
    
    private var rawValue: String {
        switch self {
        case .adMobfull   : return "adMobfull"
        case .adMobBanner : return "adMobBanner"
        }
    }
}

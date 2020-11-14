//
//  PartTimeVCModel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/12.
//  Copyright © 2020 SloWax. All rights reserved.
//

import Foundation
import SnapKit

struct PartTimeVCModel {
    
    // MARK: tableView에 있는 일 급여 합산
    func setTotalPay(data: PayList) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let value = data.month[0].data
        var result = 0
        
        for index in 0 ... value.count - 1 {
            result += value[index].totalPay
        }
        
        return formatter.string(from: result as NSNumber) ?? ""
    }
    // MARK: data 저장 및 수정 뷰 불러오기
    func loadSaveView() {
        
    }
}

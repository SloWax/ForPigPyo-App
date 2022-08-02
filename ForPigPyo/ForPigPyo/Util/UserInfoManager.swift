//
//  UserInfoManager.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/29.
//  Copyright © 2022 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa


class UserInfoManager {
    
    static let shared = UserInfoManager()
    
    private let bag = DisposeBag()
    
    let tax = BehaviorRelay<TaxCase?>(value: nil)
    
    init() {
        let index = loadTax()
        tax.accept(index)
        
        self.tax
            .bind { self.saveTax($0) }
            .disposed(by: bag)
    }
    
    // 세금 index 저장
    private func saveTax(_ tax: TaxCase?) {
        UserDefaults.standard.set(tax?.rawValue, forKey: "MyPageVCTax")
    }
    
    // 세금 index 불러오기
    private func loadTax() -> TaxCase? {
        let tax = UserDefaults.standard.object(forKey: "MyPageVCTax")
        
        guard let tax = tax as? String else { return nil }
        
        return TaxCase(rawValue: tax)
    }
}

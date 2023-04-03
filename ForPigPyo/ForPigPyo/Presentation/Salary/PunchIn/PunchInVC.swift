//
//  PunchInVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/04.
//  Copyright © 2023 SloWax. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa
import RxOptional


class PunchInVC: BaseSceneVC {
    private let punchInView = PunchInView()
    private var vm: PunchInVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> PunchInVM {
        let inputs = PunchInVM()
        
        return inputs
    }
    
    private func initialize() {
        vm = setInputs()
        
        view = punchInView
    }
    
    private func bind() {
        
    }
}

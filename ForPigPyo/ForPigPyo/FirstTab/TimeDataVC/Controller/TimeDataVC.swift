//
//  TimeDataVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/18.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class TimeDataVC: UIViewController {
    
    let timeDataView: TimeDataView = {
        let view = TimeDataView()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    private func setView() {
        
        view.addSubview(timeDataView)
        
        timeDataView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

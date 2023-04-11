//
//  PyoButton.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/25.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit


class PyoButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(.systemBackground, for: .normal)
        self.setTitleColor(.systemBackground, for: .disabled)
        
        self.setBackgroundColor(
            sel: .setCustomColor(.primaryYellow),
            nor: .setCustomColor(.primaryYellow)
        )
        self.setBackgroundColor(
            dis: .setCustomColor(.gray1),
            nor: .setCustomColor(.primaryYellow)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

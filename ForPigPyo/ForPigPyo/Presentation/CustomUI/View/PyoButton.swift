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
            sel: .setCustomColor(.yellow),
            nor: .setCustomColor(.yellow)
        )
        self.setBackgroundColor(
            dis: .setCustomColor(.lightGray),
            nor: .setCustomColor(.yellow)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

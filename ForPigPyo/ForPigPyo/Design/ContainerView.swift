//
//  ContainerView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/18.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    let label1: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let label2: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let label3: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let label4: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let label5: UILabel = {
        let label = UILabel()
        
        return label
    }()
    let label6: UILabel = {
        let label = UILabel()
        
        return label
    }()
    lazy var labelBundle = [label1, label2, label3, label4, label5, label6]
    
    let textField1: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    let textField2: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    lazy var textFieldBundle = [textField1, textField2]
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = Design.lightGray
        self.layer.cornerRadius = Design.cornerRadius
        
        labelBundle.forEach {
            
            $0.textColor = Design.textBasic
            
            self.addSubview($0)
        }
        textFieldBundle.forEach {
            
            $0.font = Design.nomalTextSize
            $0.textColor = Design.textBasic
            $0.textAlignment = .right
            
            $0.keyboardType = .numberPad
            $0.doneAccessory = true
            
            self.addSubview($0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

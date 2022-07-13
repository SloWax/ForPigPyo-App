//
//  DonePickerView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/09.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// MyPageVC tax PickerView Extension doneButton

class DonePickerView: UIView {
    
    private let doneToolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        
        return toolBar
    }()
    let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Done"
        button.style = .done
        button.tintColor = Design.textBasic
        
        return button
    }()
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        let backColor: UIColor = .systemBackground
        picker.backgroundColor = backColor.withAlphaComponent(0.65)
        
        return picker
    }()
        
    private lazy var blurEffectView = UIVisualEffectView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDoneButton()
        setPickerView()
    }
    private func setDoneButton() {
        let titleButton = UIBarButtonItem(title: "세금 설정  ", style: .plain, target: nil, action: nil)
        let backColor: UIColor = Design.textBasic
        titleButton.isEnabled = false
        titleButton.setTitleTextAttributes([.foregroundColor: backColor.withAlphaComponent(0.75)], for: .disabled)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [flexSpace, flexSpace, titleButton, flexSpace, doneButton]
        doneToolbar.items = items
        
        self.addSubview(doneToolbar)
        
        doneToolbar.snp.makeConstraints {
            
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    private func setPickerView() {
        
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView.effect = blurEffect
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurEffectView)
        
        blurEffectView.snp.makeConstraints {
            
            $0.top.equalTo(doneToolbar.snp.bottom)
            $0.height.equalTo(120)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.addSubview(pickerView)
        
        pickerView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalTo(blurEffectView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

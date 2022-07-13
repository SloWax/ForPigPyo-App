//
//  SavingAddEditView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingAddEditView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.headerTextSize
        
        return label
    }()
    
    let saveDateView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "저축월:"
        view.label2.text = "년"
        view.label3.text = "월"
        
        return view
    }()
    let saveSumView: ContainerView = {
        let view = ContainerView()
        let attributes = [NSAttributedString.Key.foregroundColor: Design.textBasic.withAlphaComponent(0.5), .font: Design.boldNomalTextSize]
        view.label1.text = "저축액:"
        view.label2.text = "원"
        
        view.textField1.attributedPlaceholder = NSAttributedString(string: "저축액", attributes: attributes as [NSAttributedString.Key: Any])
        
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Design.yellow
        
        button.setTitle("저장", for: .normal)
        button.titleLabel?.font = Design.boldNomalTextSize
        button.tintColor = .systemBackground
        
        button.layer.cornerRadius = Design.cornerRadius
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setObject()
    }
    
    private func setView() {
        
        self.backgroundColor = .systemBackground
        
        self.addSubview(saveDateView)
        
        saveDateView.snp.makeConstraints {
            
            $0.bottom.equalTo(self.snp.centerY).offset(-Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.height.equalTo(saveDateView.snp.width).multipliedBy(0.175)
        }
        
        self.addSubview(saveSumView)
        
        saveSumView.snp.makeConstraints {
            
            $0.top.equalTo(self.snp.centerY).inset(Design.nomalPadding)
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
            $0.height.equalTo(saveDateView)
        }
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.leading.equalTo(saveDateView)
            $0.bottom.equalTo(saveDateView.snp.top).offset(-Design.largestPadding)
        }
        
        self.addSubview(saveButton)
        
        saveButton.snp.makeConstraints {
            
            $0.top.equalTo(saveSumView.snp.bottom).offset(Design.largePadding)
            $0.trailing.equalTo(saveSumView).inset(Design.nomalPadding)
            $0.width.equalToSuperview().multipliedBy(0.16)
            $0.height.equalTo(saveButton.snp.width)
        }
    }
    
    private func setObject() {
        
        [saveDateView, saveSumView].forEach { (containerView) in
            
            containerView.labelBundle.forEach {
                
                $0.font = Design.boldNomalTextSize
                
                $0.snp.makeConstraints {
                    
                    $0.centerY.equalToSuperview()
                }
            }
            
            containerView.label1.snp.makeConstraints {
                
                $0.leading.equalToSuperview().inset(Design.largePadding)
            }
        }
        
        saveSumView.label2.snp.makeConstraints {
            
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
        }
        
        saveSumView.textField1.snp.makeConstraints {
            
            $0.centerY.equalTo(saveSumView.label2)
            $0.trailing.equalTo(saveSumView.label2.snp.leading).offset(-Design.smallPadding)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        saveDateView.buttonBundle.forEach {
            
            $0.titleLabel?.font = Design.boldNomalTextSize
            
            $0.snp.makeConstraints {
                
                $0.centerY.equalToSuperview()
            }
        }
        
        saveDateView.label3.snp.makeConstraints {
            
            $0.trailing.equalTo(saveSumView.label2)
        }
        
        saveDateView.button2.snp.makeConstraints {
            
            $0.trailing.equalTo(saveDateView.label3.snp.leading)
        }
        
        saveDateView.label2.snp.makeConstraints {

            $0.trailing.equalTo(saveDateView.button2.snp.leading)
        }
        
        saveDateView.button1.snp.makeConstraints {
            
            $0.trailing.equalTo(saveDateView.label2.snp.leading)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

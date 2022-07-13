//
//  EmptyView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/25.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    private let backView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emptycell")
        
        return view
    }()
    
    private let explainLabel: UILabel = {
        let label = UILabel()
        label.font = Design.boldNomalTextSize
        label.textColor = Design.textBasic
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCell()
    }
    
    private func setCell() {
        
        self.addSubview(backView)
        
        backView.snp.makeConstraints {
            
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(backView.snp.width).multipliedBy(1.2)
        }
        
        backView.addSubview(explainLabel)
        
        explainLabel.snp.makeConstraints {
            
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backView.snp.bottom).multipliedBy(0.4)
        }
    }
    
    func setValue(explain: String) {
        
        explainLabel.text = explain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

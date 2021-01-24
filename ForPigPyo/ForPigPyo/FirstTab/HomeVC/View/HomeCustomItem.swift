//
//  HomeCustomItem.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

// HomeVC CollectionView item

class HomeCustomItem: UICollectionViewCell {
    
    static let identifier = "PartCustomItem"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setItem()
        setTitleLabel()
        setSubTitleLabel()
    }
    private func setItem() {
        
        self.backgroundColor = Design.lightGray
    }
    private func setTitleLabel() {
        
        titleLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: self.frame.width / 16)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview().offset(Design.smallPadding)
            $0.leading.equalToSuperview().inset(Design.largePadding)
        }
    }
    private func setSubTitleLabel() {
        
        subTitleLabel.font = UIFont(name: "NotoSansCJKkr-Medium", size: self.frame.width / 23)
        contentView.addSubview(subTitleLabel)
        
        subTitleLabel.snp.makeConstraints {
            
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    func setValue(title: String, subTitle: String) {
        
        
        titleLabel.attributedText = title.underLine
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

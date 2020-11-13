//
//  PartCustomItem.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

class PartCustomItem: UICollectionViewCell {
    
    static let identifier = "PartCustomItem"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setItem()
        setImageView()
        setTitleLabel()
    }
    private func setItem() {
        
        self.layer.cornerRadius = Design.cornerRadius
        self.layer.borderWidth = Design.halfBorderWidth
        self.layer.borderColor = UIColor.white.cgColor
    }
    private func setImageView() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Design.smallPadding)
            $0.width.equalTo(imageView.snp.height)
        }
    }
    private func setTitleLabel() {
        
        titleLabel.font = .boldSystemFont(ofSize: self.frame.width / 14)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Design.nomalPadding)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
    }
    func setValue(image: String, text: String) {
        
        imageView.image = UIImage(systemName: image)
        titleLabel.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

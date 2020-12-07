//
//  MyPageCustomCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

class MyPageCustomCell: UITableViewCell {
    
    static let identifier = "MyPageCustomCell"
    
    private let sectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Design.textBasic
        
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setSectionImage()
        setTitleLabel()
    }
    private func setSectionImage() {
        
        contentView.addSubview(sectionImage)
        
        sectionImage.snp.makeConstraints {
            
            $0.top.leading.bottom.equalToSuperview().inset(Design.smallPadding)
            $0.width.equalTo(self.frame.width / 5)
            $0.height.equalTo(sectionImage.snp.width)
        }
    }
    private func setTitleLabel() {
        
        titleLabel.font = UIFont(name: "BMHANNA11yrsoldOTF", size: self.frame.width / 12)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.leading.equalTo(sectionImage.snp.trailing).offset(Design.nomalPadding)
            $0.centerY.equalTo(sectionImage.snp.centerY)
        }
    }
    
    func setValue(image: String, title: String?) {
        
        sectionImage.image = UIImage(systemName: image)
        titleLabel.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

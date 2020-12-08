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
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        
        return label
    }()
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.textBasic
        label.font = Design.nomalTextSize
        label.text = "미설정"
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setSectionImage()
        setTitleLabel()
        setValueLabel()
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
    private func setValueLabel() {
        
        contentView.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints {
            
            $0.trailing.equalTo(self.snp.trailing).inset(Design.LargePadding)
            $0.centerY.equalToSuperview()
        }
    }
    private func checkValue(row: Int, value: String?) -> String {
        
        guard value != nil || value != "0" else { return "미설정" }
        
        switch row {
        case 0:
            guard value != nil else { return "미설정" }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            let intValue = Int(value ?? "") ?? 0
            let result = formatter.string(from: NSNumber(value: intValue)) ?? ""
            
            return "\(result)원"
        case 1:
            
            return value ?? "미설정"
        default:
            fatalError()
        }
    }
    
    func setValue(image: String, title: String?, value: String?, row: Int) {
        
        sectionImage.image = UIImage(systemName: image)
        titleLabel.text = title
        valueLabel.text = checkValue(row: row, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

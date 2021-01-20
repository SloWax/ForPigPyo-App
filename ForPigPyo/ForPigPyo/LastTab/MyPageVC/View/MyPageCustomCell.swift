//
//  MyPageCustomCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/08.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

// MyPageVC tableView CustomCell

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
        label.text = "미설정"
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.backgroundColor = Design.lightGray
        
        setSectionImage()
        setTitleLabel()
        setValueLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
    }
    
    private func setSectionImage() {
        
        contentView.addSubview(sectionImage)
        
        sectionImage.snp.makeConstraints {
            
            $0.top.bottom.equalToSuperview().inset(Design.largePadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding)
            $0.width.equalTo(contentView.frame.width / 7)
            $0.height.equalTo(sectionImage.snp.width).multipliedBy(1.3)
        }
    }
    private func setTitleLabel() {
        
        titleLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: contentView.frame.width / 16)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.leading.equalTo(sectionImage.snp.trailing).offset(Design.largePadding)
            $0.centerY.equalTo(sectionImage.snp.centerY)
        }
    }
    private func setValueLabel() {
        
        valueLabel.font = UIFont(name: "NotoSansCJKkr-Bold", size: contentView.frame.width / 18)
        contentView.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints {
            
            $0.trailing.equalTo(contentView.snp.trailing).inset(Design.largePadding)
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
            
            return "\(result) 원"
        case 1:
            
            return value ?? "미설정"
        case 2:
            
            return value ?? "미설정"
        default:
            fatalError()
        }
    }
    
    func setValue(image: String, title: String?, value: String?, row: Int) {
        
        sectionImage.image = UIImage(named: image)
        titleLabel.text = title
        valueLabel.text = checkValue(row: row, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

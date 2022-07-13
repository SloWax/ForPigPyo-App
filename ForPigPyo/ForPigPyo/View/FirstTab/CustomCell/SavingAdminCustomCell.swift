//
//  SavingAdminCustomCell.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/21.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class SavingAdminCustomCell: UITableViewCell {
    
    static let identifier = "SavingAdminCustomCell"
    
    private let containerView: ContainerView = {
        let view = ContainerView()
        view.label1.text = "2021년"
        
        view.label2.text = "01월"
        
        view.label3.text = "10,000 원"
        
        view.labelBundle.forEach { $0.font = .setCustomFont(font: .bold, size: 20) }
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setCell()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    private func setCell() {
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Design.largePadding)
        }
        
        containerView.label1.snp.makeConstraints {
            
            $0.top.bottom.equalToSuperview().inset(Design.largePadding)
            $0.leading.equalToSuperview().inset(Design.largestPadding)
        }
        
        containerView.label2.snp.makeConstraints {
            
            $0.centerY.equalTo(containerView.label1)
            $0.leading.equalTo(containerView.label1.snp.trailing).offset(Design.nomalPadding)
        }
        
        containerView.label3.snp.makeConstraints {
            
            $0.centerY.equalTo(containerView.label1)
            $0.trailing.equalToSuperview().inset(Design.largestPadding)
        }
    }
    
    func setValue(data: SavingList.Data?) {
        
        let fomatter: NumberFormatter = {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            
            return format
        }()
        
        containerView.label1.text = "\(data?.year ?? "")년"
        
        containerView.label2.text = "\(data?.month ?? "")월"
        
        containerView.label3.text = "\(fomatter.string(from: (data?.saving ?? 0) as NSNumber) ?? "0") 원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

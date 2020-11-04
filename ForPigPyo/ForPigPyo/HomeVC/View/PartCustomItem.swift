//
//  PartCustomItem.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
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
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImageView()
        setTitle()
    }
    private func setImageView() {
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Design.smallPadding)
            $0.width.equalTo(imageView.snp.height)
        }
    }
    private func setTitle() {
        
        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Design.nomalPadding)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
    }
    func setValue(image: String, text: String) {
        
        imageView.image = UIImage(systemName: image)
        title.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

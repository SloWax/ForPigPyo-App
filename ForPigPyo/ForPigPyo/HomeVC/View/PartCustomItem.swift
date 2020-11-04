//
//  PartCustomItem.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//

import UIKit

class PartCustomItem: UICollectionViewCell {
    
    static let identifier = "PartCustomItem"
    
    let imageView = UIImageView()
    let title = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImageView()
        setTitle()
    }
    private func setImageView() {
        
        self.addSubview(imageView)
    }
    private func setTitle() {
        
        self.addSubview(title)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

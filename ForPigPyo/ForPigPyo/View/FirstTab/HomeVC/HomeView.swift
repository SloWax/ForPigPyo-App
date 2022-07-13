//
//  HomeView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import SnapKit

// HomeVC 전체 View

class HomeView: UIView {

    let partCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setPartCollection()
    }
    
    private func setPartCollection() {
        
        self.addSubview(partCollection)
        
        partCollection.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

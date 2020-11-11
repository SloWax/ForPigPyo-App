//
//  HomeVCDataSource.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: PartCustomItem.identifier, for: indexPath) as? PartCustomItem else { fatalError() }
        item.setValue(image: "dollarsign.square.fill",
                      text: "이번 달엔 얼마나 받을까 ?"
        )
        
        return item
    }
    
    
}

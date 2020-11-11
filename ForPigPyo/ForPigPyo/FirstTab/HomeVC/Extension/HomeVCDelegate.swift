//
//  HomeVCDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? PartCustomItem else { fatalError() }
        let partVC = PartTimeVC()
        partVC.title = item.titleLabel.text
        
        navigationController?.pushViewController(partVC, animated: true)
    }
}

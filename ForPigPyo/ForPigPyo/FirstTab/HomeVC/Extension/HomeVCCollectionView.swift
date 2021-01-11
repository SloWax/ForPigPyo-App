//
//  HomeVCCollectionView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit

extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCustomItem.identifier, for: indexPath) as? HomeCustomItem else { fatalError() }
        item.setValue(title: model.menu[indexPath.row].title,
                      subTitle: model.menu[indexPath.row].subTitle)
        
        return item
    }
}


extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? HomeCustomItem else { fatalError() }
        
        switch indexPath.item {
        case 0:
            let partVC = PartTimeVC()
            
//            partVC.title = item.titleLabel.text
            partVC.backImageView.image = backImageView.image
            
            navigationController?.pushViewController(partVC, animated: true)
        case 1:
            
            return
        case 2:
            let emailVC = EmailVC()
            
            emailVC.title = item.titleLabel.text
            emailVC.backImageView.image = backImageView.image
            
            navigationController?.pushViewController(emailVC, animated: true)
        default:
            fatalError()
        }
    }
}


extension HomeVC:UICollectionViewDelegateFlowLayout {
    // 줄 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Design.padding
    }
    // 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Design.padding
    }
    // 테두리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return Design.edge
    }
    // 아이템 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (Design.edge.left + Design.edge.right) - (Design.padding * (Design.partLineCount - 1))) / Design.partLineCount
        
        return CGSize(width: size, height: size / 5)
    }
}

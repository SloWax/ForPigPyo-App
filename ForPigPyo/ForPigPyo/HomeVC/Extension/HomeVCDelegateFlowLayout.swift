//
//  HomeVCDelegateFlowLayout.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/04.
//

import UIKit

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
      let size = (collectionView.frame.width - (Design.edge.left + Design.edge.right) - (Design.padding * (Design.articleLineCount - 1))) / Design.articleLineCount
      return CGSize(width: size, height: size / 2.4)
    }
}

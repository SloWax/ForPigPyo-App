//
//  Extension+UIView.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/07/21.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}

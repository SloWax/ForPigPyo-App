//
//  PaddingLabel.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/01/19.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    init(withInsets top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }

}

//class PaddingLabel: UILabel {
//    var padding: UIEdgeInsets
//
//    required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
//        self.padding = padding
//        super.init(frame: CGRect.zero)
//    }
//
//    override init(frame: CGRect) {
//        padding = UIEdgeInsets.zero
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        padding = UIEdgeInsets.zero
//        super.init(coder: aDecoder)
//    }
//
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: rect.inset(by: padding))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        let superContentSize = super.intrinsicContentSize
//        let width = superContentSize.width + padding.left + padding.right
//        let height = superContentSize.height + padding.top + padding.bottom
//
//        return CGSize(width: width, height: height)
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        let superSizeThatFits = super.sizeThatFits(size)
//        let width = superSizeThatFits.width + padding.left + padding.right
//        let heigth = superSizeThatFits.height + padding.top + padding.bottom
//
//        return CGSize(width: width, height: heigth)
//    }
//}

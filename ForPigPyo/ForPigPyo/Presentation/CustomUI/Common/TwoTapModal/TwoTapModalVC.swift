//
//  TwoTapModalVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/11.
//  Copyright © 2023 SloWax. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional


class TwoTapModalVC: BaseModalVC {
    
    private let isEnabledTapDismiss: Bool
    
    private var image: UIImage?
    private var textTitle: String?
    private var subTitle: String?
    private var cancelTitle: String?
    private var confirmTitle: String?
    
    private var eventConfirm: CallBack?
    private var eventCancel: CallBack?
    
    private let twoTapModalView = TwoTapModalView()
    
    init(isEnabledTapDismiss: Bool = true,
         image: UIImage? = nil,
         title: String,
         subTitle: String? = nil,
         cancelTitle: String = "취소",
         confirmTitle: String = "확인",
         eventCancel: CallBack? = nil,
         eventConfirm: CallBack? = nil) {
        
        self.isEnabledTapDismiss = isEnabledTapDismiss
        self.image = image
        self.textTitle = title
        self.subTitle = subTitle
        self.cancelTitle = cancelTitle
        self.confirmTitle = confirmTitle
        
        self.eventCancel = eventCancel
        self.eventConfirm = eventConfirm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func initialize() {
        view = twoTapModalView
        
        twoTapModalView.setValue(
            image: image,
            title: textTitle,
            subTitle: subTitle,
            cancelTitle: cancelTitle,
            confirmTitle: confirmTitle
        )
    }
    
    private func bind() {
        twoTapModalView.viewDismiss // 빈 공간 tap dismiss
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self,
                      self.isEnabledTapDismiss else { return }
                
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        twoTapModalView.btnCancle // 취소
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                if let callBack = self.eventCancel {
                    callBack()
                }
                
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        twoTapModalView.btnConfirm // 확인
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                if let callBack = self.eventConfirm {
                    callBack()
                }
                
                self.dismiss(animated: false)
            }.disposed(by: bag)
    }
}

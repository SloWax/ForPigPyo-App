//
//  TextFieldModalVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/11.
//  Copyright © 2022 SloWax. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxOptional

typealias OnInput = (String) -> Void

class TextFieldModalVC: BaseModalVC {
    
    private let textTitle: String?
    private let subTitle: String?
    private let titleAlign: NSTextAlignment
    
    private let placeholder: String?
    private let tfType: UIKeyboardType
    private let validSum: (min: Int, max: Int)?
    private let validPattern: String?
    private let textLimit: Int?
    private let textMin: Int?
    private let isFirstRespondse: Bool
    
    private let confirmTitle: String?
    
    private let onInput: OnInput?
    
    private let textFieldModalView = TextFieldModalView()
    
    init(title: String, subTitle: String? = nil, titleAlign: NSTextAlignment = .center,
         placeholder: String? = nil, tfType: UIKeyboardType = .default,
         validSum: (min: Int, max: Int)? = nil, validPattern: String? = nil, textLimit: Int? = nil,
         textMin: Int? = nil, isFirstRespondse: Bool = false ,
         confirmTitle: String = "확인", onInput: OnInput? = nil) {
        
        self.textTitle = title
        self.subTitle = subTitle
        self.titleAlign = titleAlign
        self.placeholder = placeholder
        self.tfType = tfType
        self.textLimit = textLimit
        self.validSum = validSum
        self.validPattern = validPattern
        self.textMin = textMin
        self.confirmTitle = confirmTitle
        self.isFirstRespondse = isFirstRespondse
        self.onInput = onInput
        
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
        view = textFieldModalView
        
        textFieldModalView.setValue(
            title: textTitle,
            subTitle: subTitle,
            titleAlign: titleAlign,
            placeholder: placeholder,
            tfType: tfType,
            confirmTitle: confirmTitle ,
            isFirstRespondse: isFirstRespondse
        )
    }
    
    private func bind() {
        textFieldModalView.viewDismiss // 빈 공간 tap dismiss
            .rx
            .tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.bag = DisposeBag()
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        textFieldModalView.tfInput // validation 확인
            .rx
            .text
            .orEmpty
            .map { $0.trim() }
            .bind { [weak self] text in
                guard let self = self else { return }
                
                var isSum: Bool = true, isValid: Bool = true, isMin: Bool = true
                
                if let validSum = self.validSum, let textInt = Int(text) {
                    isSum = (validSum.min <= textInt) && (textInt <= validSum.max)
                }
                
                if let validation = self.validPattern {
                    isValid = text.isValidation(validation)
                }
                
                if let textLimit = self.textLimit, text.count > textLimit {
                    let tf = self.textFieldModalView.tfInput
                    return tf.text = text.limitTextCount(textLimit)
                }
                
                if let textMin = self.textMin {
                    isMin = text.count >= textMin
                }
                
                let isEnabled = isSum && isValid && isMin
                let btnConfirm = self.textFieldModalView.btnConfirm
                
                btnConfirm.isEnabled = isEnabled && !text.isEmpty
            }.disposed(by: bag)
        
        textFieldModalView.btnConfirm // 확인
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                if let callBack = self.onInput,
                   let text = self.textFieldModalView.tfInput.text {
                    callBack(text)
                }
                
                self.bag = DisposeBag()
                self.dismiss(animated: false)
            }.disposed(by: bag)
        
        NotificationCenter.default // 키보드가 올라올 때
            .rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { [weak self] notification in
                guard let self = self else { return }
                
                let duration = self.getKeyBoardDuration(notification)
                let keyboardHeight = self.getKeyBoardHeight(notification)
                let bottomInset = self.view.safeAreaInsets.bottom
                let inset = keyboardHeight + bottomInset + 28
                
                UIView.animate(withDuration: duration) { [weak self] in
                    guard let self = self else { return }
                    
                    self.textFieldModalView.confirmInset?.update(inset: inset)
                    self.view.layoutIfNeeded()
                }
            }
            .subscribe()
            .disposed(by: bag)
        
        NotificationCenter.default // 키보드가 내려갈 때
            .rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { [weak self] notification in
                guard let self = self else { return }
                
                let duration = self.getKeyBoardDuration(notification)
                UIView.animate(withDuration: duration) { [weak self] in
                    guard let self = self else { return }
                    
                    self.textFieldModalView.confirmInset?.update(inset: 28)
                    self.view.layoutIfNeeded()
                }
            }
            .subscribe()
            .disposed(by: bag)
    }
}

//
//  SocialManager.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2022/08/12.
//  Copyright © 2022 SloWax. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa
import RxOptional
import AuthenticationServices


class SocialManager: NSObject {
    
    static let shared = SocialManager()
    
    private let bag = DisposeBag()
    
    let apple = PublishRelay<Void>()
    
    override init() {
        super.init()
        
        self.apple
            .bind { [weak self] in self?.handleAuthorizationApple() }
            .disposed(by: bag)
    }
    
    private func handleAuthorizationApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])

        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension SocialManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        let userIdentifier = appleIDCredential.user
        UserInfoManager.shared.login.accept(userIdentifier)
        
//        loadFromDB()
    }
}

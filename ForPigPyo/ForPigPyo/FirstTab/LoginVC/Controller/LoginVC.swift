//
//  LoginVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    static let userID = "userID"
    
    let loginView: LoginView = {
        let view = LoginView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setupProviderLoginView()
    }
    
    private func setView() {
        
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupProviderLoginView() {
        let appleLoginButton = ASAuthorizationAppleIDButton()
        appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        appleLoginButton.cornerRadius = 25
        loginView.addSubview(appleLoginButton)
        
        appleLoginButton.snp.makeConstraints {
            
            $0.bottom.equalToSuperview().multipliedBy(0.75)
            $0.leading.trailing.equalToSuperview().inset(Design.padding)
            $0.height.equalTo(appleLoginButton.snp.width).multipliedBy(0.15)
        }
    }
    
    @objc private func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let userIdentifier = appleIDCredential.user
        
        UserDefaults.standard.set(userIdentifier, forKey: LoginVC.userID)
        
        dismiss(animated: true, completion: nil)
    }
}

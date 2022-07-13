//
//  LoginVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2021/02/22.
//  Copyright © 2021 SloWax. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import AuthenticationServices

class LoginVC: UIViewController {
    
    static let userID = "userID"
    
    let loginView: LoginView = {
        let view = LoginView()
        
        return view
    }()
    
    let loginVCModel = LoginVCModel()
    let partTimeModel = PartTimeVCModel()
    let savingModel = SavingVCModel()
    
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
        loginView.addSubview(appleLoginButton)
        
        appleLoginButton.snp.makeConstraints {
            
            $0.top.equalTo(loginView.titleLabel.snp.bottom).offset(Design.padding)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(appleLoginButton.snp.width).multipliedBy(0.15)
        }
    }
    private func dataAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "모두의 앱 시작하기:)", style: .default) { _ in
            
            self.dismiss(animated: true)
        }
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
    private func loadFromDB() {
        
        loginVCModel.loadFromDB()
        
        if let tabBarVC = presentingViewController as? MainTabVC {
            if let myPageVC = tabBarVC.viewControllers?[1].children.first as? MyPageVC {
                myPageVC.myPageView.tableView.reloadData()
            }
        }
        
        dismiss(animated: true)
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
        
        loadFromDB()
    }
}

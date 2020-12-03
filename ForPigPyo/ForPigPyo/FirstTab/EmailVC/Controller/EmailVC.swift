//
//  EmailVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MessageUI

class EmailVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.purple
        
        return imageView
    }()
    private let emailView = EmailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setEmailView()
    }
    private func setView() {
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func setEmailView() {
        
        emailView.emailButton.addTarget(self, action: #selector(presentEmail(_:)), for: .touchUpInside)
        view.addSubview(emailView)
        
        emailView.snp.makeConstraints {
            
            $0.leading.trailing.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    @objc private func presentEmail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            
            let email = MFMailComposeViewController()
            
            email.mailComposeDelegate = self
            email.setToRecipients(["rjsnrl0128@kakao.com"])
            email.setSubject("개발해주세요!")
            email.setMessageBody("<p>---아래에 원하는 기능을 적어주세요!---</p>", isHTML: true)
            
            present(email, animated: true)
        } else {
            
            let alert = UIAlertController(title: nil, message: "아이폰 Mail앱 설정을 확인해 주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okButton)
            
            present(alert, animated: true)
        }
    }
}

extension EmailVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
    }
}

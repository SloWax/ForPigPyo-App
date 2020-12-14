//
//  EmailVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class EmailVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.purple
        
        return imageView
    }()
    private let emailView = EmailView()
    
    var bannerView : GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            setView()
            setEmailView()
    }
    private func setView() {
        
        interstitial = createAndLoadInterstitial()
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        bannerView = createAndLoadBannerView()
        view.addSubview(bannerView)
        
        bannerView.snp.makeConstraints {
            
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setEmailView() {
        
        emailView.emailButton.addTarget(self, action: #selector(presentEmail(_:)), for: .touchUpInside)
        view.addSubview(emailView)
        
        emailView.snp.makeConstraints {
            
            $0.leading.trailing.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createAndLoadBannerView() -> GADBannerView {
        
        let bannerView = GADBannerView()
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(view.frame.width)
        bannerView.adUnitID = EmailVCModel.bannertest
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        return bannerView
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        
        let interstitial = GADInterstitial(adUnitID: EmailVCModel.fullAdsId)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    func checkAds() {
        
        guard interstitial.isReady else { return }
        
        interstitial.present(fromRootViewController: self)
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

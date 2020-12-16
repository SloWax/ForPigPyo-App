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
    // set View
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
        // 배너광고 초기화
        let bannerView = GADBannerView()
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(view.frame.width)
        bannerView.adUnitID = EmailVCModel.bannerAdsId
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        return bannerView
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        // 전면광고 초기화
        let interstitial = GADInterstitial(adUnitID: EmailVCModel.fullAdsId)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    func checkAds() {
        // 전면광고가 준비되었을 경우 present, else tanksAlert
        interstitial.isReady ? interstitial.present(fromRootViewController: self) : thanksAlert()
    }
    func thanksAlert() {
        // email을 보내고 창을 dismiss 하면 감사인사 ^^
        let alert = UIAlertController(title: nil, message: "소중한 의견 감사합니다!!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "별말씀을:)", style: .default)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
    
    @objc private func presentEmail(_ sender: UIButton) {
        // 기기 내 메일 앱 설정이 완료되었는지 확인 후 mail present, else 확인 Alert
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

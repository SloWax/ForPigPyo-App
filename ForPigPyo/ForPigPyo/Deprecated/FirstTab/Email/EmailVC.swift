//
//  EmailVC.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MessageUI
//import GoogleMobileAds

class EmailVC: UIViewController {
    
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    let emailView: EmailView = {
        let view = EmailView()
        
        return view
    }()
    
//    var bannerView: GADBannerView!
//    var interstitial: GADInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            setView()
    }
    // set View
    private func setView() {
        
//        interstitial = createAndLoadInterstitial()
        
        view.addSubview(backImageView)
        
        backImageView.snp.makeConstraints {
            
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
//        bannerView = createAndLoadBannerView()
//        view.addSubview(bannerView)
//
//        bannerView.snp.makeConstraints {
            
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
        
        emailView.emailButton.addTarget(self, action: #selector(presentEmail(_:)), for: .touchUpInside)
        view.addSubview(emailView)
        
        emailView.snp.makeConstraints {
            
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            $0.bottom.equalTo(bannerView.snp.top)
        }
    }
    
//<<<<<<< HEAD:ForPigPyo/ForPigPyo/View/FirstTab/EmailVC/EmailVC.swift
//    private func createAndLoadBannerView() -> GADBannerView {
//        // 배너광고 초기화
//        let bannerView = GADBannerView()
//        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(view.frame.width)
//        bannerView.adUnitID = EmailVCModel.bannerAdsId
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//
//        return bannerView
//    }
//=======
//    private func createAndLoadBannerView() -> GADBannerView {
//        // 배너광고 초기화
//        let bannerView = GADBannerView()
//        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(view.frame.width)
//        bannerView.adUnitID = SDKIdentifier.adMobBanner.key
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//
//        return bannerView
//    }
//>>>>>>> 08681b9fc6f919d86b658e1031c816edabe9daa6:ForPigPyo/ForPigPyo/View/FirstTab/Email/EmailVC.swift
//    func createAndLoadInterstitial() -> GADInterstitialAd {
//        // 전면광고 초기화
//        let interstitial = GADInterstitialAd(adUnitID: EmailVCModel.fullAdsId)
//        interstitial.delegate = self
//        interstitial.load(GADRequest())
//
//        return interstitial
//    }
    func checkAds() {
//        // 전면광고가 준비되었을 경우 present, else tanksAlert
//        interstitial.isReady ? interstitial.present(fromRootViewController: self) : thanksAlert()
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

extension EmailVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // 메일 dismiss 후 광고 check
        controller.dismiss(animated: true)
        
//        checkAds()
    }
}

//<<<<<<< HEAD:ForPigPyo/ForPigPyo/View/FirstTab/EmailVC/EmailVC.swift
//extension EmailVC: GADBannerViewDelegate {
//
//    func interstitialDidDismissScreen(_ ads: GADInterstitialAd) {
//        // 전면광고는 매번 새로 받아야 하기 때문에 광고가 꺼진 후 새 광고를 생성
////        interstitial = createAndLoadInterstitial()
//        thanksAlert()
//    }
//}
//=======
//extension EmailVC: GADBannerViewDelegate {
//
//    func interstitialDidDismissScreen(_ ads: GADInterstitialAd) {
//        // 전면광고는 매번 새로 받아야 하기 때문에 광고가 꺼진 후 새 광고를 생성
////        interstitial = createAndLoadInterstitial()
//        thanksAlert()
//    }
//}


import UIKit
import RxSwift
import RxCocoa
import MessageUI
//import GoogleMobileAds


class NewEmailVC: BaseVC {
    private let emailView = NewEmailView()
    private var vm: EmailVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        bind()
    }
    
    private func setInputs() -> EmailVM {
        return EmailVM()
    }
    
    private func initialize() {
        vm = setInputs()
    }
    
    private func bind() {
        
    }
}
//>>>>>>> 08681b9fc6f919d86b658e1031c816edabe9daa6:ForPigPyo/ForPigPyo/View/FirstTab/Email/EmailVC.swift

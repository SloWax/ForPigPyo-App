//
//  EmailVCMailCompose.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/07.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

extension EmailVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // 메일 dismiss 후 광고 check
        controller.dismiss(animated: true)
        
        checkAds()
    }
}


extension EmailVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        // 전면광고는 매번 새로 받아야 하기 때문에 광고가 꺼진 후 새 광고를 생성
        interstitial = createAndLoadInterstitial()
        thanksAlert()
    }
}


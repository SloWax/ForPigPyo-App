//
//  EmailVCDelegate.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/12/04.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

extension EmailVC: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
        
        let alert = UIAlertController(title: "후원해주실래요?", message: "광고시청은 굶주린 저의 배를 채워주어 개발이 더욱 빨라질 수 있습니다.", preferredStyle: .alert)
        let noButton = UIAlertAction(title: "안 봐욧!", style: .default)
        let okButton = UIAlertAction(title: "볼래요!", style: .default) {_ in
            
            self.interstitial.present(fromRootViewController: self)
        }
        
        alert.addAction(noButton)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}

extension EmailVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
        interstitial = createAndLoadInterstitial()
        
        let alert = UIAlertController(title: nil, message: "후원 감사합니다!!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "별말씀을:)", style: .default)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}

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
        
        controller.dismiss(animated: true)
        
        checkAds()
    }
}


extension EmailVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
        interstitial = createAndLoadInterstitial()
        
        let alert = UIAlertController(title: nil, message: "소중한 의견 감사합니다!!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "별말씀을:)", style: .default)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}


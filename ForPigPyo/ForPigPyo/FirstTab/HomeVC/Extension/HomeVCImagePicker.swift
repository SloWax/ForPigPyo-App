//
//  HomeVCImagePicker.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2020/11/28.
//  Copyright © 2020 SloWax. All rights reserved.
//

import UIKit
import MobileCoreServices

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.presentingViewController?.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        
        saveBackImage(image: image)
        backImageView.image = image
        
        picker.presentingViewController?.dismiss(animated: true)
    }
}

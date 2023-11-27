//
//  FirebaseManager.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/10.
//  Copyright © 2023 SloWax. All rights reserved.
//


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    func getDocument(_ userID: String, response: @escaping (Result<BackupDto<[AttendanceDto]>?, Error>) -> Void) {
        let firestore = Firestore.firestore()
        let documentKey = firestore.collection(userID).document("TimeCard")
        
        documentKey.getDocument { (document, error ) in
            let result = Result { try document?.data(as: BackupDto<[AttendanceDto]>.self) }
            
            response(result)
        }
    }
    
    func uploadDocument(_ userID: String) {
        let firestore = Firestore.firestore()
        
        let data = DataManager.shared
            .retrieve()
            .map {
                let data = AttendanceDto(
                    id: $0.id,
                    date: $0.date,
                    wage: $0.wage,
                    workTime: $0.combineTime(.work),
                    overTime: $0.combineTime(.over),
                    nightTime: $0.combineTime(.night),
                    overNightTime: $0.combineTime(.overNight),
                    total: $0.combineTime(.total),
                    dayPay: $0.dayPay
                )
                
                return data
            }
        
        let backup = BackupDto(
            data: data,
            metaDate: Date()
        )
        
        do {
            try firestore.collection(userID).document("TimeCard").setData(from: backup)
        } catch let error {
            print("Error: \(error)")
        }
    }
}

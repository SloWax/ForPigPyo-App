//
//  BackupDto.swift
//  ForPigPyo
//
//  Created by 표건욱 on 2023/04/10.
//  Copyright © 2023 SloWax. All rights reserved.
//


import Foundation

struct BackupDto<T: Codable>: Codable {
    let data: T
    let metaDate: Date
}

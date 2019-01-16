//
//  PhotoJournal.swift
//  PhotoJournal
//
//  Created by Manny Yusuf on 1/16/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    let createdAt: String
    let imageData: Data
    let description: String
}

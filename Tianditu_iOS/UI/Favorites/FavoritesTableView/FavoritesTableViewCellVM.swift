//
//  FavoritesTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
import JTFramework

class FavoritesTableViewCellVM {
    let id: Int64?
    let x: Double?
    let y: Double?
    let name: String?
    let typeStr: String?
    let type: Tianditu_NameSearchType?
    let region: String?
    let county: String?
    let phone: String?
    let address: String?
    let datafrom: Int16?
    let imageAddress: String?
    let uuidStr: String?
    
    init(data: Data_Favorite) {
        id = data.id
        x = data.x
        y = data.y
        name = data.name
        typeStr = data.typeStr
        if let t = typeStr {
            type = Tianditu_NameSearchType(rawValue: t)
        } else { type = nil }
        region = data.region
        county = data.county
        phone = data.phone
        address = data.address
        datafrom = data.datafrom
        imageAddress = data.imageAddress
        uuidStr = data.uuid
    }
}

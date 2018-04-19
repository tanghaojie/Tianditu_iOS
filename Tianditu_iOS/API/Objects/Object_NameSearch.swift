//
//  Object_NameSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_NameSearch: Mappable {
    var columns: [Object_Column]?
    var features: [Object_Feature]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        columns            <- map["columns"]
        features     <- map["features"]
    }
}

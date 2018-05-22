//
//  Object_RouteItem.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_RouteItem: Mappable {
    var strguide: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        strguide  <- map["strguide"]
    }
}

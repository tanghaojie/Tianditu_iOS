//
//  Object_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_RouteSearch: Mappable {
    var route: Object_Route?
    var directions: [Object_Direction]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        route            <- map["route"]
        directions     <- map["directions"]
    }
}

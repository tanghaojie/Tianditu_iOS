//
//  Response_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Response_RouteSearch: Mappable {
    var distance: String?
    var simpleItems: Any?
    var routeItems: [Object_RouteItem]?
    var center: String?
    var scale: String?
    var routelatlon: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        distance     <- map["distance"]
        simpleItems  <- map["simpleItems"]
        routeItems  <- map["routeItems"]
        center     <- map["center"]
        scale  <- map["scale"]
        routelatlon  <- map["routelatlon"]
    }
}

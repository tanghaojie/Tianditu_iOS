//
//  Request_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Request_RouteSearch {
    var orig: String?
    var dest: String?
    var mid: String?
    var style: String?
    
    init(startX: Double, startY: Double, stopX: Double, stopY: Double, style: RouteStyle = .short) {
        orig = String(startX) + "," + String(startY)
        dest = String(stopX) + "," + String(stopY)
        mid = nil
        self.style = style.rawValue
    }
    required init?(map: Map) {}
}
extension Request_RouteSearch: Mappable {
    
    func mapping(map: Map) {
        orig     <- map["orig"]
        dest  <- map["dest"]
        mid  <- map["mid"]
        style  <- map["style"]
    }
}
enum RouteStyle: String {
    case fast = "0"
    case short = "1"
    case avoidHighWay = "2"
    case walk = "3"
}

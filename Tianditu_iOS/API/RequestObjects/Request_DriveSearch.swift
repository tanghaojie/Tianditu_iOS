//
//  Request_DriveSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2019/1/16.
//  Copyright © 2019 JT. All rights reserved.
//

import ObjectMapper

class Request_DriveSearch {
    var orig: String?
    var dest: String?
    var mid: String?
    var style: String?
    
    init(startX: Double, startY: Double, stopX: Double, stopY: Double, style: DriveStyle = .short) {
        orig = String(startX) + "," + String(startY)
        dest = String(stopX) + "," + String(stopY)
        mid = nil
        self.style = style.rawValue
    }
    required init?(map: Map) {}
}
extension Request_DriveSearch: Mappable {
    
    func mapping(map: Map) {
        orig     <- map["orig"]
        dest  <- map["dest"]
        mid  <- map["mid"]
        style  <- map["style"]
    }
}
enum DriveStyle: String {
    case short = "0"
    case avoidHighWay = "1"
    case walk = "2"
}

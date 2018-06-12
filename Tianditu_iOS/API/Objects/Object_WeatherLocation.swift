//
//  Object_WeatherLocation.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_WeatherLocation: Mappable {
    var id: String?
    var name: String?
    var country: String?
    var path: String?
    var timezone: String?
    var timezone_offset: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        id            <- map["id"]
        name            <- map["name"]
        country            <- map["country"]
        path            <- map["path"]
        timezone            <- map["timezone"]
        timezone_offset            <- map["timezone_offset"]
    }
}

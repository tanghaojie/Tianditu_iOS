//
//  Object_WeatherResult.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_WeatherResult: Mappable {
    var location: Object_WeatherLocation?
    var daily: [Object_WeatherDaily]?
    var last_update: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        location            <- map["location"]
        daily            <- map["daily"]
        last_update            <- map["last_update"]
    }
}

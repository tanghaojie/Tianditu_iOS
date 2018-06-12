//
//  Object_WeatherDaily.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_WeatherDaily: Mappable {
    var date: String?
    var text_day: String?
    var code_day: String?
    var text_night: String?
    var code_night: String?
    var high: String?
    var low: String?
    var precip: String?
    var wind_direction: String?
    var wind_direction_degree: String?
    var wind_speed: String?
    var wind_scale: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        date            <- map["date"]
        text_day            <- map["text_day"]
        code_day            <- map["code_day"]
        text_night            <- map["text_night"]
        code_night            <- map["code_night"]
        high            <- map["high"]
        low            <- map["low"]
        precip            <- map["precip"]
        wind_direction            <- map["wind_direction"]
        wind_direction_degree            <- map["wind_direction_degree"]
        wind_speed            <- map["wind_speed"]
        wind_scale            <- map["wind_scale"]
    }
}

//
//  Response_Weather.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Response_Weather: Mappable {
    var results: [Object_WeatherResult]?
    required init?(map: Map) {}
    func mapping(map: Map) {
        results     <- map["results"]
    }
}

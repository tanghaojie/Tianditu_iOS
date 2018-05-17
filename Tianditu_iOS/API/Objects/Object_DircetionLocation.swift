//
//  Object_DircetionLocation.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_DirectionLocation: Mappable {
    var x: Double?
    var y: Double?
    required init?(map: Map) {}
    func mapping(map: Map) {
        x            <- map["x"]
        y            <- map["y"]
    }
}

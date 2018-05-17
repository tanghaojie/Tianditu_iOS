//
//  Object_Direction.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_Direction: Mappable {
    var decription: String?
    var length: Double?
    var cumulativeLength: Double?
    var dircetionLocation: Object_DirectionLocation?
    var dircetionLine: Any?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        decription            <- map["decription"]
        length            <- map["length"]
        cumulativeLength            <- map["cumulativeLength"]
        dircetionLocation            <- map["dircetionLocation"]
        dircetionLine            <- map["dircetionLine"]
    }
}

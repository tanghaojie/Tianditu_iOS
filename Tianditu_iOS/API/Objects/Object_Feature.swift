//
//  Object_Feature.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_Feature: Mappable {
    
    var attributes: [Any]?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        attributes            <- map["attributes"]
    }
}

//
//  Object_Route.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_Route: Mappable {
    var paths: [[[Double]]]?

    required init?(map: Map) {}
    func mapping(map: Map) {
        paths            <- map["paths"]
    }
}

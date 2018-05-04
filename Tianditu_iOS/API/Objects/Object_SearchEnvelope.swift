//
//  Object_SearchEnvelope.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/4.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_SearchEnvelope: Mappable {
    var xmin: Double?
    var ymin: Double?
    var xmax: Double?
    var ymax: Double?
    
    init(xmin: Double, ymin: Double, xmax: Double, ymax: Double) {
        self.xmin = xmin
        self.ymin = ymin
        self.xmax = xmax
        self.ymax = ymax
    }
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        xmin            <- map["xmin"]
        ymin     <- map["ymin"]
        xmax     <- map["xmax"]
        ymax     <- map["ymax"]
    }
}

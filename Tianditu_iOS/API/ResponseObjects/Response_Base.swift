//
//  Response_Base.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Response_Base: Mappable {
    var success: Bool?
    var version: String?
    var description: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        success     <- map["success"]
        version  <- map["version"]
        description  <- map["description"]
    }
}

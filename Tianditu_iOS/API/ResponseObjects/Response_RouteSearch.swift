//
//  Response_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Response_RouteSearch: Response_Base {
    var message: Object_RouteSearch?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        message    <- map["message"]
    }
}

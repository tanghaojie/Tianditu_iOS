//
//  Response_NameSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Response_NameSearch: Response_Base {
    var message: Object_NameSearch?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        message    <- map["message"]
    }
}

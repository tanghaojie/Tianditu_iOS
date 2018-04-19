//
//  Object_Column.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper

class Object_Column: Mappable {
    var columnName: String?
    var dataType: String?
    var caption: String?
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        columnName            <- map["columnName"]
        dataType     <- map["dataType"]
        caption     <- map["caption"]
    }
}

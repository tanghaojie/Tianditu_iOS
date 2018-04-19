//
//  Request_NameSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

class Request_NameSearch {
    
    let keyname: String?
    var DiQuKey: String?
    var QuXianKey: String?
    let isOnlyName: Bool
    var SearchEnvelope: String?
    let typeCode: Int?
    let StartIndex: Int
    let StopIndex: Int
    var token: String?
    let pretty: Bool
    let st: Int64 = Int64(Date().timeIntervalSince1970)
    
    init(name: String, start: Int, end: Int, nameOnly: Bool = false, p: Bool = false) {
        keyname = name
        typeCode = nil
        StartIndex = start
        StopIndex = end
        isOnlyName = nameOnly
        pretty = p
    }
    init(type: Int, start: Int, end: Int, nameOnly: Bool = false, p: Bool = false) {
        keyname = nil
        typeCode = type
        StartIndex = start
        StopIndex = end
        isOnlyName = nameOnly
        pretty = p
    }
}

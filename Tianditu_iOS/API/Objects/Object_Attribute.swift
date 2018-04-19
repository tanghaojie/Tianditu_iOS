//
//  Object_Arr.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

class Object_Attribute {
    
    var id: Int?
    var x: Double?
    var y: Double?
    var name: String?
    var typeStr: String?
    var type: Tianditu_NameSearchType?
    var region: String?
    var county: String?
    var phone: String?
    var address: String?
    var datafrom: Int?
    var imageAddress: String?
    
    init(data: [Any]) {
        guard data.count == 11 else { return }
        id = data[0] as? Int
        x = data[1] as? Double
        y = data[2] as? Double
        name = data[3] as? String
        typeStr = data[4] as? String
        region = data[5] as? String
        county = data[6] as? String
        phone = data[7] as? String
        address = data[8] as? String
        datafrom = data[9] as? Int
        imageAddress = data[10] as? String
        
        if let t = typeStr {
            type = Tianditu_NameSearchType(rawValue: t)
            if type == nil {
                type = Tianditu_NameSearchType.unknown
            }
        }
    }
    
    
}


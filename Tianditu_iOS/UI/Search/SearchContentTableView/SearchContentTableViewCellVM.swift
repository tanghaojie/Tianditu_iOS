//
//  SearchContentTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class SearchContentTableViewCellVM {
    
    let data: Object_Attribute?
    
    let title: String?
    let detail: String?
    
    init(_ r: Object_Attribute) {
        data = r
        title = r.name
        let region = r.region ?? ""
        let county = r.county ?? ""
        let address = r.address ?? ""
        detail = region + " " + county + " " + address
    }
}


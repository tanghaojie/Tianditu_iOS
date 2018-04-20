//
//  SearchHistoryTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class SearchHistoryTableViewCellVM {
    
    let data: Object_Attribute?
    
    let nameOnly: Bool
    
    let title: String?
    let detail: String?
    
    init(_ r: Object_Attribute) {
        if let x = r.x, let y = r.y, x > 0.1, y > 0.1 {
            nameOnly = false
        } else {
            nameOnly = true
        }
        data = r
        
        title = data!.name
        let region = data!.region ?? ""
        let county = data!.county ?? ""
        let address = data!.address ?? ""
        detail = region + " " + county + " " + address
    }
    
}

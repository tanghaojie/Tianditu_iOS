//
//  SearchHistoryTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class RouteHistoryTableViewCellVM {
    
    let startType: RouteType
    let startName: String?
    let startX: Double
    let startY: Double
    let stopType: RouteType
    let stopName: String?
    let stopX: Double
    let stopY: Double

    init(startType: RouteType,
         startName: String? = nil,
         startX: Double,
         startY: Double,
         stopType: RouteType,
         stopName: String? = nil,
         stopX: Double,
         stopY: Double) {
        self.startType = startType
        self.startName = startName
        self.startX = startX
        self.startY = startY
        self.stopType = stopType
        self.stopName = stopName
        self.stopX = stopX
        self.stopY = stopY
    }
    
}

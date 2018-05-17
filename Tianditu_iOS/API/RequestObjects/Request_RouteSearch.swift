//
//  Request_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

class Request_RouteSearch {
    
    let StartX: Double
    let StartY: Double
    let StopX: Double
    let StopY: Double
    let powerColumnName: String
    let returnDirection: Bool
    let VIAPoints: String?
    let BarriesLocation: String?
    let token: String?
    let pretty: Bool
    let st: Int64 = Int64(Date().timeIntervalSince1970)
    
    init(startX: Double, startY: Double, stopX: Double, stopY: Double, powerColumnName: String = "length", returnDirection: Bool = true, VIAPoints: String? = nil, BarriesLocation: String? = nil, token: String? = nil, pretty: Bool = false) {
        StartX = startX
        StartY = startY
        StopX = stopX
        StopY = stopY
        self.powerColumnName = powerColumnName
        self.returnDirection = returnDirection
        self.VIAPoints = VIAPoints
        self.BarriesLocation = BarriesLocation
        self.token = token
        self.pretty = pretty
    }
}

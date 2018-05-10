//
//  RoutePosition.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/9.
//  Copyright © 2018年 JT. All rights reserved.
//

class RoutePosition {
    let type: RouteType
    let name: String?
    let x: Double
    let y: Double
    init(type: RouteType, name: String? = nil, x: Double, y: Double) {
        self.type = type
        self.name = name
        self.x = x
        self.y = y
    }
}
extension RoutePosition {
    func showPosition(_ bar: UISearchBar) {
        if type == .coordinate {
            bar.text = name
        } else if type == .myPlace {
            bar.text = LocalizableStrings.myPlace
        }
    }
}

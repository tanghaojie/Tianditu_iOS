//
//  Date.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

extension Date {
    var jtDateAndTimeFormateString: String {
        return DateFormatter.jtDateAndTimeFormatter.string(from: self)
    }
}

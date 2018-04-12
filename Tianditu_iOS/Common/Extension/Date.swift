//
//  Date.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
extension Date {
    var toJTDateAndTimeFormateString: String {
        return DateFormatter.JTDateAndTimeFormatter.string(from: self)
    }
}

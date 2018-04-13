//
//  DateFormatter.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

extension DateFormatter {
    static var jtDateAndTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateAndTimeFormate
        return dateFormatter
    }()
    static var jtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateFormate
        return dateFormatter
    }()
}

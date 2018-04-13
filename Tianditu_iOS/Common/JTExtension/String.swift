//
//  String.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

extension String {
    var jtUtf8Encoded: Data {
        return data(using: .utf8)!
    }
    var jtDateAndTimeFormateDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateAndTimeFormate
        return dateFormatter.date(from: self)
    }
    func jtContainsCaseInsensitive(other: String) -> Bool {
        return self.range(of: other, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
}

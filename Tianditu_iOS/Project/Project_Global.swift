//
//  Project_Global.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//
import UIKit

let global_DateAndTimeFormate = "yyyy-MM-dd HH:mm:ss"
let global_DateFormate = "yyyy-MM-dd"
enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
}

extension UIColor{
    convenience init(red : CGFloat, green : CGFloat, blue : CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    var toJTDateAndTimeFormateDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateAndTimeFormate
        return dateFormatter.date(from: self)
    }
    func containsCaseInsensitive(other: String) -> Bool {
        return self.range(of: other, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
}
extension Date {
    var toJTDateAndTimeFormateString: String {
        return DateFormatter.JTDateAndTimeFormatter.string(from: self)
    }
}
extension DateFormatter {
    static var JTDateAndTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateAndTimeFormate
        return dateFormatter
    }()
    static var JTDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = global_DateFormate
        return dateFormatter
    }()
}

var global_TodayStartDate: Date? = {
    let date = Date()
    let cal = Calendar.current
    var dateComponents = cal.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    dateComponents.hour = 0
    dateComponents.minute = 0
    dateComponents.second = 0
    return cal.date(from: dateComponents)
}()

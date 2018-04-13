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

var global_TodayStartDate: Date? = {
    let date = Date()
    let cal = Calendar.current
    var dateComponents = cal.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    dateComponents.hour = 0
    dateComponents.minute = 0
    dateComponents.second = 0
    return cal.date(from: dateComponents)
}()



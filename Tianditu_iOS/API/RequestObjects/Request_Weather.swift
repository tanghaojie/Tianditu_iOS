//
//  Request_Weather.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

class Request_Weather {
    private static let myKey = "mfjrhxubx6hdv6jy"
    let key: String
    let location: String
    let language: String
    let unit: String
    let start: String
    let days: Int
    
    init(key: String = myKey, latitude: String, longitude: String, language: String = LocalizableStrings.weatherLanguage, unit: String = "c", start: String = "0", days: Int = 1) {
        self.key = key
        self.location = "\(latitude):\(longitude)"
        self.language = language
        self.unit = unit
        self.start = start
        self.days = days
    }
}

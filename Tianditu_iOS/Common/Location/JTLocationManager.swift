//
//  JTLocationManager.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class JTLocationManager: CLLocationManager {
    static let shareInstance = JTLocationManager()
    
    private override init(){
        super.init()
        requestAlwaysAuthorization()
        desiredAccuracy = kCLLocationAccuracyBestForNavigation
        pausesLocationUpdatesAutomatically = false
        allowsBackgroundLocationUpdates = true
    }
}

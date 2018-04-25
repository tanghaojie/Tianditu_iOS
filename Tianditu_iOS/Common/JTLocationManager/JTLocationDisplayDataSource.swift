//
//  JTLocationDisplayDataSource.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

class JTLocationDisplayDataSource: NSObject, AGSLocationDisplayDataSource, CLLocationManagerDelegate {
    
    static let shareInstance = JTLocationDisplayDataSource()
    
    var delegate: AGSLocationDisplayDataSourceDelegate!
    var isStarted: Bool
    var error: Error!
    
    private override init() {
        isStarted = false
        super.init()
        JTLocationManager.shareInstance.delegate = self
    }
    deinit {
        print("----release JTLocationDisplayDataSource")
    }
    func start() {
        JTLocationManager.shareInstance.startUpdatingLocation()
        JTLocationManager.shareInstance.startUpdatingHeading()
        delegate.locationDisplayDataSourceStarted(self)
        isStarted = true
    }
    func stop() {
        JTLocationManager.shareInstance.stopUpdatingLocation()
        JTLocationManager.shareInstance.stopUpdatingHeading()
        delegate.locationDisplayDataSourceStopped(self)
        isStarted = false
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate.locationDisplayDataSource(self, didUpdateWith: AGSLocation(clLocation: locations.last))
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        delegate.locationDisplayDataSource(self, didUpdateWithHeading: newHeading.trueHeading)
    }
}

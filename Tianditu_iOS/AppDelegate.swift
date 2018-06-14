//
//  AppDelegate.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import CoreData
import JTFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Bundle.updateMainToJTBundle()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Tianditu_Datas.shareInstance.saveContext()
    }

}

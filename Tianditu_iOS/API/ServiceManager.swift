//
//  ServiceManager.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import Alamofire
import Moya

class ServiceManager {
    static let shareInstance = ServiceManager()
    private init() {}
    
    let scTiandituProvider = MoyaProvider<SCTiandituService>(manager: DefaultAlamofireManager.sharedManager)
    let tiandituProvider = MoyaProvider<TiandituService>(manager: DefaultAlamofireManager.sharedManager)
    let tiandituProvider_10s = MoyaProvider<TiandituService>(manager: DefaultAlamofireManager_10.sharedManager)
    let seniverseProvider = MoyaProvider<SeniverseService>(manager: DefaultAlamofireManager.sharedManager)

    private class DefaultAlamofireManager: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 5
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    private class DefaultAlamofireManager_10: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 10
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
}

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
    //let provider_2s = MoyaProvider<SCTiandituService>(manager: DefaultAlamofireManager_2.sharedManager)
    //let provider_300s = MoyaProvider<SCTiandituService>(manager: DefaultAlamofireManager_300.sharedManager)

    private class DefaultAlamofireManager: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 5
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    private class DefaultAlamofireManager_2: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 2
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    private class DefaultAlamofireManager_300: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 300
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
}

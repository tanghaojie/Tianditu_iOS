//
//  Weather.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya

class WeatherC {
    public static let shareInstance = WeatherC()
    private init() {}
    
    private var cancellable: Cancellable?
    
    private func cancel() {
        guard let cancel = cancellable else { return }
        if cancel.isCancelled { return }
        cancel.cancel()
    }
    
    func weather(latitude: String, longitude: String, Complete: @escaping (Bool, Response_Weather?, String?) -> Void) {
        cancel()
        cancellable = ServiceManager.shareInstance.seniverseProvider.request(.weather(data: Request_Weather(latitude: latitude, longitude: longitude))) {
            result in
            switch result {
            case let .success(moyaResponse):
                guard 200 == moyaResponse.statusCode else {
                    Complete(false, nil, LocalizableStrings.httpRequestFailed + String(moyaResponse.statusCode))
                    return
                }
                let str = String(data: moyaResponse.data, encoding: .utf8)
                guard let json = str else {
                    Complete(false, nil, LocalizableStrings.noResponseContent)
                    return
                }
                let res = Response_Weather(JSONString: json)
                guard let r = res else {
                    Complete(false, nil, LocalizableStrings.errorResponseContentDataFormat)
                    return
                }
                Complete(true, r, nil)
            case let .failure(error):
                let errorDescription = error.errorDescription
                Complete(false, nil, errorDescription)
            }
        }
    }

}

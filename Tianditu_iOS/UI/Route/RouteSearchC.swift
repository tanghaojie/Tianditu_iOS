//
//  RouteSearchC.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya

class RouteSearchC {
    public static let shareInstance = RouteSearchC()
    private init() {}

    private var cancellable: Cancellable?

    private func cancel() {
        guard let cancel = cancellable else { return }
        if cancel.isCancelled { return }
        cancel.cancel()
    }

    func routeSearch(startX: Double, startY: Double, stopX: Double, stopY: Double, style: RouteStyle = .short, Complete: @escaping (Bool, Response_RouteSearch?, String?) -> Void) {
        cancel()
        let data = Request_RouteSearch(startX: startX, startY: startY, stopX: stopX, stopY: stopY, style: style)
        cancellable = ServiceManager.shareInstance.tiandituProvider.request(.routeSearch(data: data)) {
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
                let res = Response_RouteSearch(JSONString: json)
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

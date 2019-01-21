//
//  DriveSearchC.swift
//  Tianditu_iOS
//
//  Created by JT on 2019/1/16.
//  Copyright © 2019 JT. All rights reserved.
//

import Moya

class DriveSearchC {
    public static let shareInstance = DriveSearchC()
    private init() {}
    
    private var cancellable: Cancellable?
    
    private func cancel() {
        guard let cancel = cancellable else { return }
        if cancel.isCancelled { return }
        cancel.cancel()
    }
    
    func driveSearch(startX: Double, startY: Double, stopX: Double, stopY: Double, style: DriveStyle = .short, Complete: @escaping (Bool, Response_RouteSearch?, String?) -> Void) {
        cancel()
        let data = Request_DriveSearch(startX: startX, startY: startY, stopX: stopX, stopY: stopY, style: style)
        cancellable = ServiceManager.shareInstance.newTiandituProvider_15s.request(.driveSearch(data: data)) {
            result in
            switch result {
            case let .success(moyaResponse):
                guard 200 == moyaResponse.statusCode else {
                    Complete(false, nil, LocalizableStrings.httpRequestFailed + String(moyaResponse.statusCode))
                    return
                }
                guard let xml = String(data: moyaResponse.data, encoding: .utf8) else {
                    Complete(false, nil, LocalizableStrings.noResponseContent)
                    return
                }
                guard let r = Response_RouteSearch(xml: xml) else {
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

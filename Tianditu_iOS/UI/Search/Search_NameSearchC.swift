//
//  Search_NameSearchC.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya
import JTFramework

class Search_NameSearchC {
    public static let shareInstance = Search_NameSearchC()
    private init() {}
    
    private var cancellable: Cancellable?
    
    private func cancel() {
        guard let cancel = cancellable else { return }
        if cancel.isCancelled { return }
        cancel.cancel()
    }
    
    func nameSearch(text: String, start: Int, end: Int, Complete: @escaping (Bool, Response_NameSearch?, String?) -> Void) {
        cancel()
        if text == "" {
            Complete(false, nil, LocalizableStrings.noRequestContent)
            return
        }
        let data = Request_NameSearch(name: text, start: start, end: end)
        cancellable = ServiceManager.shareInstance.scTiandituProvider.request(.nameSearch(data: data)) {
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
                let res = Response_NameSearch(JSONString: json)
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
    
    func typeSearch(type: Tianditu_NameSearchType, start: Int, end: Int, envelope: Object_SearchEnvelope? = nil, Complete: @escaping (Bool, Response_NameSearch?, String?) -> Void) {
        cancel()
        if type == .unknown {
            Complete(false, nil, LocalizableStrings.unknownType)
            return
        }
        let data = Request_NameSearch(type: type.strNum, start: start, end: end, searchEnvelope: envelope)
        cancellable = ServiceManager.shareInstance.scTiandituProvider.request(.nameSearch(data: data)) {
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
                let res = Response_NameSearch(JSONString: json)
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

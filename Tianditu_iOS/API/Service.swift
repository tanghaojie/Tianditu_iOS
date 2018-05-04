//
//  Service.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya
enum Service {
    case nameSearch(data: Request_NameSearch)
}
extension Service: TargetType {
    var baseURL: URL { return URL(string: APIURL.baseUrl)! }
    var path: String {
        switch self {
        case .nameSearch:
            return APIURL.nameSearch
        }
    }
    var method: Moya.Method {
        switch self {
        case .nameSearch:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .nameSearch(let data):
            return Task.requestParameters(parameters: [
                "keyname": (data.keyname ?? "") as Any,
                "DiQuKey": (data.DiQuKey ?? "") as Any,
                "QuXianKey": (data.QuXianKey ?? "") as Any,
                "isOnlyName": data.isOnlyName,
                "SearchEnvelope": (data.SearchEnvelope?.toJSONString() ?? "") as Any,
                "typeCode": (data.typeCode ?? "") as Any,
                "StartIndex": data.StartIndex,
                "StopIndex": data.StopIndex,
                "token": (data.token ?? "") as Any,
                "pretty": data.pretty,
                "st": data.st
                ], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .nameSearch:
            return "nil".jtUtf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "text/plain"]
    }
}

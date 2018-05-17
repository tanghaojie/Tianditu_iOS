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
    case routeSearch(data: Request_RouteSearch)
}
extension Service: TargetType {
    var baseURL: URL { return URL(string: APIURL.baseUrl)! }
    var path: String {
        switch self {
        case .nameSearch:
            return APIURL.nameSearch
        case .routeSearch:
            return APIURL.routeSearch
        }
    }
    var method: Moya.Method {
        switch self {
        case .nameSearch, .routeSearch:
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
                "st": data.st,
                ], encoding: URLEncoding.queryString)
        case .routeSearch(let data):
            return Task.requestParameters(parameters: [
                "StartX": data.StartX,
                "starty": data.StartY,
                "stopx": data.StopX,
                "stopy": data.StopY,
                "powerColumnName": data.powerColumnName,
                "returnDirection": data.returnDirection,
                "VIAPoints": data.VIAPoints ?? "",
                "BarriesLocation": data.BarriesLocation ?? "",
                "token": data.token ?? "",
                "pretty": data.pretty,
                "st": data.st,
                ], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .nameSearch, .routeSearch:
            return "nil".jtUtf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "text/plain"]
    }
}

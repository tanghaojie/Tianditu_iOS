//
//  TiandituService.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya
enum TiandituService {
    case routeSearch(data: Request_RouteSearch)
}
extension TiandituService: TargetType {
    var baseURL: URL { return URL(string: APIURL_Tianditu.baseUrl)! }
    var path: String {
        switch self {
        case .routeSearch:
            return APIURL_Tianditu.routeSearch
        }
    }
    var method: Moya.Method {
        switch self {
        case .routeSearch:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .routeSearch(let data):
            return Task.requestParameters(parameters: [
                "postStr": data.toJSONString() ?? "",
                "type": "search",
                ], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .routeSearch:
            return "nil".jtUtf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "text/plain"]
    }
}

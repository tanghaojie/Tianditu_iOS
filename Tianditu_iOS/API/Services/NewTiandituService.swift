//
//  NewTiandituService.swift
//  Tianditu_iOS
//
//  Created by JT on 2019/1/16.
//  Copyright © 2019 JT. All rights reserved.
//

import Moya

enum NewTiandituService{
    case driveSearch(data: Request_DriveSearch)
}
extension NewTiandituService: TargetType {
    var baseURL: URL { return URL(string: URL_NewTianditu.baseUrl)! }
    var path: String {
        switch self {
        case .driveSearch:
            return URL_NewTianditu.driveSearch
        }
    }
    var method: Moya.Method {
        switch self {
        case .driveSearch:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .driveSearch(let data):
            return Task.requestParameters(parameters: [
                "postStr": data.toJSONString() ?? "",
                "type": "search",
                "tk":"547bcd6a63bd42146ffb898cc0ed0b01",
                ], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .driveSearch:
            return "nil".jtUtf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "text/plain"]
    }
}

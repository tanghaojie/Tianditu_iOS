//
//  SeniverseService.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import Moya
enum SeniverseService {
    case weather(data: Request_Weather)
}
extension SeniverseService: TargetType {
    var baseURL: URL { return URL(string: URL_Seniverse.baseUrl)! }
    var path: String {
        switch self {
        case .weather:
            return URL_Seniverse.weather
        }
    }
    var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .weather(let data):
            return Task.requestParameters(parameters: [
                "key": data.key,
                "location": data.location,
                "language": data.language,
                "unit": data.unit,
                "start": data.start,
                "days": data.days,
                ], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Foundation.Data {
        switch self {
        case .weather:
            return "nil".jtUtf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "text/plain"]
    }
}

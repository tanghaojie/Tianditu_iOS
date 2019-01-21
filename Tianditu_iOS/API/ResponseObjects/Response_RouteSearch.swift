//
//  Response_RouteSearch.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import ObjectMapper
import SwiftyXMLParser

class Response_RouteSearch: Mappable {
    var distance: String?
    var simpleItems: Any?
    var routeItems: [Object_RouteItem]?
    var center: String?
    var scale: String?
    var routelatlon: String?
    
    public init?(xml: String) {
        guard let doc = try? XML.parse(xml)  else { return nil }
        guard
            case .singleElement(let distanceElement) = doc.result.distance,
            let distance = distanceElement.text,
            case .singleElement(let centerElement) = doc.result.mapinfo.center,
            let center = centerElement.text,
            case .singleElement(let scaleElement) = doc.result.mapinfo.scale,
            let scale = scaleElement.text,
            case .singleElement(let routelatlonElement) = doc.result.routelatlon,
            let routelatlon = routelatlonElement.text,
            case .sequence(let sequence) = doc.result.routes.item,
            sequence.count > 0
        else { return nil }
        
        self.distance = distance
        self.center = center
        self.scale = scale
        self.routelatlon = routelatlon
        self.routeItems = [Object_RouteItem]()
        
        for item in sequence {
            guard item.childElements.count > 0, item.childElements[0].name == "strguide", let strguide = item.childElements[0].text else { continue }
            self.routeItems?.append(Object_RouteItem(strguide: strguide))
        }
    }
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        distance     <- map["distance"]
        simpleItems  <- map["simpleItems"]
        routeItems  <- map["routeItems"]
        center     <- map["center"]
        scale  <- map["scale"]
        routelatlon  <- map["routelatlon"]
    }
}

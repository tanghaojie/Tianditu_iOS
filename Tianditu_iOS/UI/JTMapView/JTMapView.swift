//
//  JTMapView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
import UIKit

class JTMapView: AGSMapView {
    public static let shareInstance = JTMapView()
    weak var jtDelegate: JTMapViewDelegate?
    private let dlgLayerName = "dlgLayer"
    private let domLayerName = "domLayer"
    private let symbolLayerName = "jtTemporaryMapSymbolLayer"
    private let symbolLineLayerName = "jtTemporaryMapSymbolLineLayer"
    private let centerDistance = 0.0002
    private init() {
        super.init(frame: CGRect.zero)
        setup()
        addDLGLayer()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        addDLGLayer()
    }
}
extension JTMapView {
    private func setup() {
        SCGISUtility.registerESRI()
        JTLocationDisplayDataSource.shareInstance.jtDelegate = self
        locationDisplay.dataSource = JTLocationDisplayDataSource.shareInstance
        layerDelegate = self
        gridLineWidth = 10
    }
}
extension JTMapView: JTLocationDisplayDataSourceDelegate {
    func updateHeading() {
        jtDelegate?.didMapViewUpdateHeading(rotationAngle: rotationAngle)
    }
}
extension JTMapView {
    func addDLGLayer() {
        if let dom = mapLayer(forName: domLayerName) {
            removeMapLayer(dom)
        }
        addTilemapServerLayer(url: URL_SCTianditu.scmobile_dlg, name: dlgLayerName)
    }
    func addDOMLayer() {
        if let dlg = mapLayer(forName: dlgLayerName) {
            removeMapLayer(dlg)
        }
        addTilemapServerLayer(url: URL_SCTianditu.sctilemap_dom, name: domLayerName, token: URL_SCTianditu.sctianditu_token)
    }
    private func addTilemapServerLayer(url: String, name: String, token: String? = nil) {
        let tilemap = SCGISTilemapServerLayer(serviceUrlStr: url, token: token, cacheType: SCGISTilemapCacheTypeArcGISFile)
        guard let t = tilemap else { return }
        addMapLayer(t, withName: name)
    }
}
extension JTMapView: AGSMapViewLayerDelegate {
    func mapViewDidLoad(_ mapView: AGSMapView!) {
        let map = mapLayers[0] as! AGSTiledLayer
        let envelop = map.initialEnvelope
        zoom(to: envelop, animated: true)
        locationDisplay.startDataSource()
        locationDisplay.autoPanMode = .default
    }
}
extension JTMapView {
    func locationTouchUpInside(_ useCompassNavigation: Bool = true) {
        guard let l = JTLocationManager.shareInstance.location else { return }
        let px = AGSPoint(location: l)
        guard let p = px else { return }
        let d = p.distance(to: visibleAreaEnvelope.center)
        zoom(toScale: 30000, withCenter: p, animated: true)
        if d > centerDistance {
            locationDisplay.autoPanMode = .default
        } else {
            if useCompassNavigation {
                locationDisplay.autoPanMode = .compassNavigation
            } else {
                locationDisplay.autoPanMode = .default
            }
        }
    }
}
extension JTMapView {
    func removeAllAdded() {
        removeSymbolLayer()
        removeSymbolLayerPolyline()
    }
}
extension JTMapView {
    func symbolLayerPolyline(isVisible: Bool = true) {
        let layer = mapLayer(forName: symbolLineLayerName)
        layer?.isVisible = isVisible
    }
    func removeSymbolLayerPolyline() {
        removeMapLayer(mapLayer(forName: symbolLineLayerName))
    }
    private func createPolyline(points: [(x: Double, y: Double)]) -> AGSPolyline? {
        if points.count <= 1 { return nil }
        let spatialReference = JTMapView.shareInstance.spatialReference
        let line = AGSMutablePolyline(spatialReference: spatialReference)
        line?.addPathToPolyline()
        for point in points {
            let agsP = AGSPoint(location: CLLocation(latitude: point.x, longitude: point.y))
            line?.addPoint(toPath: agsP)
        }
        return line
    }
    func addSymbolLayerPolyline(points: [(x: Double, y: Double)]) {
        let polyline = createPolyline(points: points)
        guard let pLine = polyline else { return }
        let layer = mapLayer(forName: symbolLineLayerName)
        var graphicLayer = layer as? AGSGraphicsLayer
        let sr = spatialReference
        if graphicLayer == nil {
            removeMapLayer(layer)
            graphicLayer = AGSGraphicsLayer(spatialReference: sr)
            addMapLayer(graphicLayer, withName: symbolLineLayerName)
        }
        guard let gl = graphicLayer else { abort() }
        let lineSymbol = AGSSimpleLineSymbol.init(color: .blue, width: 5)
        lineSymbol?.style = .solid
        let graphic = AGSGraphic(geometry: pLine, symbol: lineSymbol, attributes: nil)
        gl.addGraphic(graphic)
        symbolLayerPolyline()
    }
}
extension JTMapView {
    func removeSymbolLayer() {
        removeMapLayer(mapLayer(forName: symbolLayerName))
    }
    func addSymbolLayerLocationPoints(points: [(x: Double, y: Double)]) {
        if points.count <= 0 { return }
        let layer = mapLayer(forName: symbolLayerName)
        removeMapLayer(layer)
        let graphicLayer = AGSGraphicsLayer(spatialReference: spatialReference)
        addMapLayer(graphicLayer, withName: symbolLayerName)
        
        guard let gl = graphicLayer, let img = Assets.location else { abort() }
        gl.isVisible = true
        gl.removeAllGraphics()
        let markerSymbol = AGSPictureMarkerSymbol(image: img)
        markerSymbol?.offset = CGPoint(x: 0, y: 15)
        for p in points {
            let graphic = AGSGraphic(geometry: AGSPoint(x: p.x, y: p.y, spatialReference: spatialReference), symbol: markerSymbol, attributes: nil)
            gl.addGraphic(graphic)
        }
    }
}
protocol JTMapViewDelegate: NSObjectProtocol {
    func didMapViewUpdateHeading(rotationAngle: Double)
}

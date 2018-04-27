//
//  JTMapView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class JTMapView: AGSMapView {
    
    public static let shareInstance = JTMapView()
    private let symbolLayerName = "jtTemporaryMapSymbolLayer"
    private init() {
        super.init(frame: CGRect.zero)
        setup()
        addLayer()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        addLayer()
    }
}
extension JTMapView: AGSMapViewLayerDelegate {
    private func setup() {
        accessibilityIdentifier = "xxx"
        SCGISUtility.registerESRI()
        locationDisplay.dataSource = JTLocationDisplayDataSource.shareInstance
        layerDelegate = self
        gridLineWidth = 10
    }
    func mapViewDidLoad(_ mapView: AGSMapView!) {
        let map = mapLayers[0] as! AGSTiledLayer
        let envelop = map.initialEnvelope
        zoom(to: envelop, animated: true)
        locationDisplay.startDataSource()
        locationDisplay.autoPanMode = .default
    }
    private func addLayer() {
        addTilemapServerLayer(url: "http://www.scgis.net.cn/imap/imapserver/defaultrest/services/scmobile_dlg/")
    }
    private func addTilemapServerLayer(url: String) {
        let tilemap = SCGISTilemapServerLayer(serviceUrlStr: url, token: nil, cacheType: SCGISTilemapCacheTypeArcGISFile)
        guard let t = tilemap else { return }
        addMapLayer(t)
    }
}
extension JTMapView {
    func removeSymbolLayer() {
        removeMapLayer(mapLayer(forName: symbolLayerName))
    }
    func addSymbolLayerLocationPoints(points: [(x: Double, y: Double)]) {
        if points.count <= 0 { return }
        let layer = mapLayer(forName: symbolLayerName)
        var graphicLayer = layer as? AGSGraphicsLayer
        let sr = spatialReference
        if graphicLayer == nil {
            removeMapLayer(layer)
            graphicLayer = AGSGraphicsLayer(spatialReference: sr)
            addMapLayer(graphicLayer, withName: symbolLayerName)
        }
        guard let gl = graphicLayer else { abort() }
        guard let img = Assets.location else { abort() }
        let markerSymbol = AGSPictureMarkerSymbol(image: img)
        markerSymbol?.offset = CGPoint(x: 0, y: 30)
        for p in points {
            let graphic = AGSGraphic()
            graphic.geometry = AGSPoint(x: p.x, y: p.y, spatialReference: sr)
            graphic.symbol = markerSymbol
            gl.addGraphic(graphic)
        }
        
    }
}

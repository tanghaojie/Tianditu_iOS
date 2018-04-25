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

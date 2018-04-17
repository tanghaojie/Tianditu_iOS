//
//  ViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/11.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class MainViewController: UIViewController {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var agsMapView: AGSMapView!
    @IBOutlet weak var transparentView: JTTransparentUIView!
    
    private let centerDistance = 0.0002
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLocation()
        setupMapView()
        addLayer()
    }
    
    @IBAction func functionTouchUpInside(_ sender: Any) {
        let functionView = FunctionView()
        functionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(functionView)
        view.addConstraints([
            NSLayoutConstraint(item: functionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)])
        functionView.transform = CGAffineTransform(translationX: -functionView.pageWidth, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            functionView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) {
            finish in
            if finish {
                functionView.didFinishAnimation()
            }
        }
    }
    @IBAction func searchTouchUpInside(_ sender: Any) {
        print("search")
        let n = UINavigationController(rootViewController: SearchViewController())
        n.isNavigationBarHidden = true
        present(n, animated: false, completion: nil)
    }
    @IBAction func messageTouchUpInside(_ sender: Any) {
        print("message")
    }
    @IBAction func layerTouchUpInside(_ sender: Any) {
        print("layer")
    }
    @IBAction func nearTouchUpInside(_ sender: Any) {
        print("near")
    }
    @IBAction func locationTouchUpInside(_ sender: Any) {
        let x = JTLocationManager.shareInstance.location
        guard let l = x else { return }
        let px = AGSPoint(location: l)
        guard let p = px else { return }
        let d = p.distance(to: agsMapView.visibleAreaEnvelope.center)
        agsMapView.center(at: p, animated: true)
        if d > centerDistance {
            agsMapView.locationDisplay.autoPanMode = .default
        } else {
            agsMapView.locationDisplay.autoPanMode = .compassNavigation
        }
    }
    @IBAction func routeTouchUpInside(_ sender: Any) {
        print("route")
    }
    
    
}
extension MainViewController {
    
    private func startLocation() {
        JTLocationManager.shareInstance.startUpdatingLocation()
        JTLocationManager.shareInstance.startUpdatingHeading()
    }

}

extension MainViewController: AGSMapViewLayerDelegate {
    
    private func setupMapView() {
        SCGISUtility.registerESRI()
        agsMapView.layerDelegate = self
        agsMapView.gridLineWidth = 10
    }
    
    func mapViewDidLoad(_ mapView: AGSMapView!) {
        let map = mapView.mapLayers[0] as! AGSTiledLayer
        let envelop = map.initialEnvelope
        mapView.zoom(to: envelop, animated: false)
        mapView.locationDisplay.startDataSource()
        mapView.locationDisplay.autoPanMode = .default
    }
    
    private func addLayer() {
        addTilemapServerLayer(url: "http://www.scgis.net.cn/imap/imapserver/defaultrest/services/scmobile_dlg/")
    }
    
    private func addTilemapServerLayer(url:String) {
        let tilemap = SCGISTilemapServerLayer(serviceUrlStr: url, token: nil, cacheType: SCGISTilemapCacheTypeArcGISFile)
        guard let t = tilemap else { return }
        agsMapView.addMapLayer(t)
    }
    
}


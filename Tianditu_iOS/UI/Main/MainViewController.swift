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
    @IBOutlet weak var transparentView: JTTransparentUIView!
    @IBOutlet weak var compassView: UIView!
    private var isFirstAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        JTMapView.shareInstance.removeAllAdded()
        JTMapView.shareInstance.jtDelegate = self
        guard mapView.subviews.count <= 0 else { return }
        setupJTMapView()
        if isFirstAppear {
            JTMapView.shareInstance.zoom(in: true)
            isFirstAppear = false
        }
    }
    
    @IBAction func functionTouchUpInside(_ sender: Any) {
        let functionView = FunctionView()
        functionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(functionView)
        view.addConstraints([
            NSLayoutConstraint(item: functionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            ])
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
        let s = SearchViewController()
        s.searchDelegate = self
        let n = UINavigationController(rootViewController: s)
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
        let n = UINavigationController(rootViewController: NearViewController())
        n.isNavigationBarHidden = true
        present(n, animated: false, completion: nil)
    }
    @IBAction func locationTouchUpInside(_ sender: Any) {
        JTMapView.shareInstance.locationTouchUpInside()
    }
    @IBAction func routeTouchUpInside(_ sender: Any) {
        let n = UINavigationController(rootViewController: RouteViewController())
        n.isNavigationBarHidden = true
        present(n, animated: false, completion: nil)
    }
    @IBAction func compassTouchUpInside(_ sender: Any) {
        JTMapView.shareInstance.locationDisplay.autoPanMode = .off
        JTMapView.shareInstance.rotationAngle = 0
        compassView.transform = CGAffineTransform.identity
        compassView.isHidden = true
    }
}
extension MainViewController {
    private func setupJTMapView() {
        let jtMapView = JTMapView.shareInstance
        jtMapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(jtMapView)
        NSLayoutConstraint.activate([
            jtMapView.topAnchor.constraint(equalTo: mapView.topAnchor),
            jtMapView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            jtMapView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            jtMapView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            ])
    }
}
extension MainViewController: JTMapViewDelegate {
    func didMapViewUpdateHeading(rotationAngle: Double) {
        if rotationAngle == 0 {
            compassView.isHidden = true
        } else {
            compassView.isHidden = false
            compassView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * CGFloat(360 - rotationAngle) / 180)
        }
    }
}
extension MainViewController: SearchViewControllerDelegate {
    func searchPosition(_ searchViewController: SearchViewController, position: Object_Attribute) {
        let v = SearchMapViewController(position: position)
        searchViewController.navigationController?.pushViewController(v, animated: false)
    }
    func searchText(_ searchViewController: SearchViewController, name: String) {
        let v = SearchMapViewController(text: name)
        searchViewController.navigationController?.pushViewController(v, animated: false)
    }
}

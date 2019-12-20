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

    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var transparentView: JTTransparentUIView!
    @IBOutlet weak var compassView: UIView!
    private var isFirstAppear = true
    private var weather: Response_Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routeButton.setImage(Assets.route, for: .normal)
        getWeather()
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
        if let w = weather, let r = w.results, r.count > 0, let location = r[0].location, let n = location.name, let daily = r[0].daily, daily.count > 0, let low = daily[0].low, let high = daily[0].high {
            var x = ""
            if let dd = daily[0].text_day, let nn = daily[0].text_night, dd != "", nn != "" {
                x = "\(LocalizableStrings.day):\(dd) \(LocalizableStrings.night):\(nn)"
            }
            let text = "\(n) \(low)~\(high)℃ \(x)"
            functionView.setWeather(text: text)
        }
        getWeather()
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
        let selectLayerView = SelectLayerView.loadFromNib()
        selectLayerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectLayerView)
        NSLayoutConstraint.activate([
            selectLayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectLayerView.topAnchor.constraint(equalTo: view.topAnchor),
            selectLayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            selectLayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
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
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil){
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
extension MainViewController {
    private func getWeather() {
        if let w = weather, let results = w.results, results.count > 0 {
            for result in results {
                guard let last = result.last_update, let lastDate = last.jtCurrentLocaleDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"), (Date().timeIntervalSince(lastDate)) / 3600 < 24 else {
                    if let location = JTLocationManager.shareInstance.location {
                        WeatherC.shareInstance.weather(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)) {
                            [weak self]
                            success, result, _ in
                            guard success, let r = result else { return }
                            self?.weather = r
                        }
                    }
                    break
                }
            }
        } else {
            if let location = JTLocationManager.shareInstance.location {
                WeatherC.shareInstance.weather(latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)) {
                    [weak self]
                    success, result, _ in
                    guard success, let r = result else { return }
                    self?.weather = r
                }
            }
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

//
//  RouteViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
import JTFramework

class RouteViewController: JTNavigationViewController {
    let startSearchBar = JTSearchBar()
    let stopSearchBar = JTSearchBar()
    private let naviHeight: CGFloat = 100
    private var startX: X?
    private var stopX: X?
    private let exchangeButton = UIButton()
    private let exchangeButtonWidth: CGFloat = 40
    private let exchangeButtonHeight: CGFloat = 80
    private let exchangeButtonMargin: CGFloat = 10
    private let routeHistoryTableView = RouteHistoryTableView()
    private let routeMapViewView = UIView()
    private let routeResultView = UIView()
    private var routeResultTopView: UIView?
    private var routeResultTopLeftView: UIView?
    private var routeResultTopLeftViewButton: UIButton?
    private var routeResultTopRightView: UIView?
    private var routeResultTopRightViewButton: UIButton?
    private var routeResultTopCenterLabel: UILabel?
    private var routeResultBottomView: UIView?
    private var routeResultBottomLeftView: UIView?
    private var routeResultBottomRightView: UIView?

    
    private let routeResultViewHeight: CGFloat = 120
    var start: RoutePosition?
    var stop: RoutePosition?
    private let toleranceDistence = 0.0006
    private var routeResult: Response_RouteSearch?
    
    init() {
        start = RoutePosition(type: .myPlace, x: 0, y: 0)
        super.init(naviHeight)
        startX = X(startSearchBar, vc: self)
        stopX = X(stopSearchBar, vc: self)
        setupUI()
        start?.showPosition(startSearchBar)
        mapView(show: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        start = RoutePosition(type: .myPlace, x: 0, y: 0)
        super.init(coder: aDecoder)
        startX = X(startSearchBar, vc: self)
        stopX = X(stopSearchBar, vc: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JTMapView.shareInstance.symbolLayerPolyline(isVisible: true)
    }

}
extension RouteViewController {
    private func setupUI() {
        setupJTNavigation()
        setupExchangeButton()
        setupStartJTSearchBar()
        setupStopJTSearchBar()
        setupRouteHistoryTableView()
        setupRouteResultView()
        setupRouteMapViewView()
    }
    private func setupJTNavigation() {
        view.backgroundColor = .white
    }
    private func setupExchangeButton() {
        exchangeButton.translatesAutoresizingMaskIntoConstraints = false
        exchangeButton.backgroundColor = .red
        navigationContent.addSubview(exchangeButton)
        NSLayoutConstraint.activate([
            exchangeButton.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor, constant: exchangeButtonMargin),
            exchangeButton.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            exchangeButton.widthAnchor.constraint(equalToConstant: exchangeButtonWidth),
            exchangeButton.heightAnchor.constraint(equalToConstant: exchangeButtonHeight),
            ])
    }
    private func setupStartJTSearchBar() {
        startSearchBar.translatesAutoresizingMaskIntoConstraints = false
        startSearchBar.placeholder = LocalizableStrings.inputStartPosition
        navigationContent.addSubview(startSearchBar)
        clearClearButton(startSearchBar)
        NSLayoutConstraint.activate([
            startSearchBar.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            startSearchBar.leadingAnchor.constraint(equalTo: navigationContent.leadingAnchor),
            startSearchBar.trailingAnchor.constraint(equalTo: exchangeButton.leadingAnchor),
            startSearchBar.heightAnchor.constraint(equalToConstant: naviHeight / 2),
            ])
        startSearchBar.delegate = self
    }
    private func setupStopJTSearchBar() {
        stopSearchBar.translatesAutoresizingMaskIntoConstraints = false
        stopSearchBar.placeholder = LocalizableStrings.inputStopPosition
        navigationContent.addSubview(stopSearchBar)
        clearClearButton(stopSearchBar)
        NSLayoutConstraint.activate([
            stopSearchBar.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            stopSearchBar.leadingAnchor.constraint(equalTo: navigationContent.leadingAnchor),
            stopSearchBar.trailingAnchor.constraint(equalTo: exchangeButton.leadingAnchor),
            stopSearchBar.heightAnchor.constraint(equalToConstant: naviHeight / 2),
            ])
        stopSearchBar.delegate = self
    }
    private func setupRouteHistoryTableView() {
        routeHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(routeHistoryTableView)
        NSLayoutConstraint.activate([
            routeHistoryTableView.topAnchor.constraint(equalTo: content.topAnchor),
            routeHistoryTableView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            routeHistoryTableView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            routeHistoryTableView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
        routeHistoryTableView.jtDelegate = self
        routeHistoryTableView.isHidden = false
    }
    private func setupRouteMapViewView() {
        routeMapViewView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(routeMapViewView)
        NSLayoutConstraint.activate([
            routeMapViewView.topAnchor.constraint(equalTo: content.topAnchor),
            routeMapViewView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            routeMapViewView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            routeMapViewView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
        routeMapViewView.isHidden = true
    }
    private func setupRouteResultView() {
        routeResultView.translatesAutoresizingMaskIntoConstraints = false
        routeResultView.backgroundColor = .white
        content.addSubview(routeResultView)
        NSLayoutConstraint.activate([
            routeResultView.heightAnchor.constraint(equalToConstant: routeResultViewHeight),
            routeResultView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            routeResultView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            routeResultView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
        routeResultView.isHidden = true
    }
    private func setupMapView() {
        if routeMapViewView.subviews.count <= 0 {
            JTMapView.shareInstance.translatesAutoresizingMaskIntoConstraints = false
            routeMapViewView.addSubview(JTMapView.shareInstance)
            NSLayoutConstraint.activate([
                JTMapView.shareInstance.topAnchor.constraint(equalTo: routeMapViewView.topAnchor),
                JTMapView.shareInstance.bottomAnchor.constraint(equalTo: routeMapViewView.bottomAnchor),
                JTMapView.shareInstance.leadingAnchor.constraint(equalTo: routeMapViewView.leadingAnchor),
                JTMapView.shareInstance.trailingAnchor.constraint(equalTo: routeMapViewView.trailingAnchor),
                ])
        }
    }
    
    
    
    
    
    private func addTopView() {
        routeResultTopView = UIView()
        guard let t = routeResultTopView else { return }
        t.backgroundColor = .red
        t.translatesAutoresizingMaskIntoConstraints = false
        routeResultView.addSubview(t)
        NSLayoutConstraint.activate([
            t.leadingAnchor.constraint(equalTo: routeResultView.leadingAnchor),
            t.trailingAnchor.constraint(equalTo: routeResultView.trailingAnchor),
            t.topAnchor.constraint(equalTo: routeResultView.topAnchor),
            t.heightAnchor.constraint(equalTo: routeResultView.heightAnchor, multiplier: 0.5),
            ])
        addTopLeft()
        addTopRight()
        addTopCenter()
    }
    private func addTopLeft() {
        routeResultTopLeftView = UIView()
        routeResultTopLeftViewButton = UIButton()
        guard let t = routeResultTopView, let left = routeResultTopLeftView, let btn = routeResultTopLeftViewButton else { return }
        left.translatesAutoresizingMaskIntoConstraints = false
        t.addSubview(left)
        left.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            left.leadingAnchor.constraint(equalTo: t.leadingAnchor),
            left.topAnchor.constraint(equalTo: t.topAnchor),
            left.bottomAnchor.constraint(equalTo: t.bottomAnchor),
            left.widthAnchor.constraint(equalTo: t.heightAnchor),
            ])

        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftRightTouchUpInside), for: .touchUpInside)
        left.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: left.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: left.trailingAnchor),
            btn.topAnchor.constraint(equalTo: left.topAnchor),
            btn.bottomAnchor.constraint(equalTo: left.bottomAnchor),
            ])
    }
    private func addTopRight() {
        routeResultTopRightView = UIView()
        routeResultTopRightViewButton = UIButton()
        guard let t = routeResultTopView, let right = routeResultTopRightView, let btn = routeResultTopRightViewButton else { return }
        right.translatesAutoresizingMaskIntoConstraints = false
        t.addSubview(right)
        right.backgroundColor = .green
        NSLayoutConstraint.activate([
            right.trailingAnchor.constraint(equalTo: t.trailingAnchor),
            right.topAnchor.constraint(equalTo: t.topAnchor),
            right.bottomAnchor.constraint(equalTo: t.bottomAnchor),
            right.widthAnchor.constraint(equalTo: t.heightAnchor),
            ])
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(leftRightTouchUpInside), for: .touchUpInside)
        right.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: right.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: right.trailingAnchor),
            btn.topAnchor.constraint(equalTo: right.topAnchor),
            btn.bottomAnchor.constraint(equalTo: right.bottomAnchor),
            ])
    }
    private func addTopCenter() {
        routeResultTopCenterLabel = UILabel()
        guard let t = routeResultTopView, let center = routeResultTopCenterLabel, let left = routeResultTopLeftView, let right = routeResultTopRightView else { return }
        center.font = UIFont.systemFont(ofSize: 14)
        center.textAlignment = .center
        center.lineBreakMode = .byWordWrapping
        center.numberOfLines = 3
        center.translatesAutoresizingMaskIntoConstraints = false
        t.addSubview(center)
        center.backgroundColor = .white
        NSLayoutConstraint.activate([
            center.leadingAnchor.constraint(equalTo: left.trailingAnchor),
            center.topAnchor.constraint(equalTo: t.topAnchor),
            center.bottomAnchor.constraint(equalTo: t.bottomAnchor),
            center.trailingAnchor.constraint(equalTo: right.leadingAnchor),
            ])
        center.tag = 0
        setRouteResultViewTopCenterLabel()
    }
    
    private func addBottomView() {
        routeResultBottomView = UIView()
        guard let b = routeResultBottomView else { return }
        b.translatesAutoresizingMaskIntoConstraints = false
        routeResultView.addSubview(b)
        NSLayoutConstraint.activate([
            b.leadingAnchor.constraint(equalTo: routeResultView.leadingAnchor),
            b.trailingAnchor.constraint(equalTo: routeResultView.trailingAnchor),
            b.bottomAnchor.constraint(equalTo: routeResultView.bottomAnchor),
            b.heightAnchor.constraint(equalTo: routeResultView.heightAnchor, multiplier: 0.5),
            ])
        addBottomLeft()
        addBottomRight()
    }
    private func addBottomLeft() {
        routeResultBottomLeftView = UIView()
        guard let left = routeResultBottomLeftView, let v = routeResultBottomView else { return }
        left.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(left)
        left.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            left.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            left.topAnchor.constraint(equalTo: v.topAnchor),
            left.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            left.widthAnchor.constraint(equalTo: v.widthAnchor, multiplier: 0.5),
            ])
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        left.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: left.leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: left.trailingAnchor),
            btn.topAnchor.constraint(equalTo: left.topAnchor),
            btn.bottomAnchor.constraint(equalTo: left.bottomAnchor),
            ])
    }
    private func addBottomRight() {
        routeResultBottomRightView = UIView()
        guard let right = routeResultBottomRightView, let v = routeResultBottomView else { return }
        right.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(right)
        NSLayoutConstraint.activate([
            right.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            right.topAnchor.constraint(equalTo: v.topAnchor),
            right.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            right.widthAnchor.constraint(equalTo: v.widthAnchor, multiplier: 0.5),
            ])
        
        let label = UILabel()
        if let r = routeResult, let d = r.distance {
            label.text = "\(LocalizableStrings.about) \(d) \(LocalizableStrings.km)"
        }
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(r: 120, g: 120, b: 120)
        label.translatesAutoresizingMaskIntoConstraints = false
        right.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: right.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: right.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: right.topAnchor),
            label.bottomAnchor.constraint(equalTo: right.bottomAnchor),
            ])
    }
}
extension RouteViewController {
    private func setRouteResultViewTopCenterLabel() {
        guard let center = routeResultTopCenterLabel, let r = routeResult else { return }
        var tag = center.tag
        guard let items = r.routeItems else { return }
        if tag < 0 { tag = tag + items.count }
        center.tag = tag % items.count
        tag = center.tag
        guard tag < items.count && tag >= 0 else { return }
        center.text = items[tag].strguide
    }
    @objc private func leftRightTouchUpInside(sender: UIButton) {
        guard let center = routeResultTopCenterLabel else { return }
        if sender == routeResultTopLeftViewButton {
            center.tag = center.tag - 1
        } else if sender == routeResultTopRightViewButton {
            center.tag = center.tag + 1
        }
        setRouteResultViewTopCenterLabel()
    }
}
extension RouteViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let s = SearchViewController(true)
        if searchBar == startSearchBar {
            s.searchDelegate = startX
        } else if searchBar == stopSearchBar {
            s.searchDelegate = stopX
        } else { return false }
        navigationController?.pushViewController(s, animated: false)
        return false
    }
}
extension RouteViewController {
    private func clearClearButton(_ view: UIView) {
        for v in view.subviews {
            if v.isKind(of: UITextField.self) {
                let x = v as? UITextField
                x?.clearButtonMode = .never
                return
            }
            if v.subviews.count > 0 {
                clearClearButton(v)
            }
        }
    }
}
extension RouteViewController: JTRouteHistoryTableViewDelegate {
    func didSelectedHistory(vm: RouteHistoryTableViewCellVM) {
        start = RoutePosition(type: vm.startType, name: vm.startName, x: vm.startX, y: vm.startY)
        stop = RoutePosition(type: vm.stopType, name: vm.stopName, x: vm.stopX, y: vm.stopY)
        start?.showPosition(startSearchBar)
        stop?.showPosition(stopSearchBar)
        showRoute()
    }
}
extension RouteViewController {
    func showRoute() {
        routeResultView(false)
        routeResult = nil
        guard let i = start, let j = stop else { return }
        mapView(show: true)
        if i.type == .myPlace && j.type == .myPlace { return }
        var x1 = i.x
        var y1 = i.y
        var x2 = j.x
        var y2 = j.y
        if i.type == .myPlace {
            guard let l = JTLocationManager.shareInstance.location else { return }
            x1 = l.coordinate.longitude
            y1 = l.coordinate.latitude
        }
        if j.type == .myPlace {
            guard let l = JTLocationManager.shareInstance.location else { return }
            x2 = l.coordinate.longitude
            y2 = l.coordinate.latitude
        }
        let xx = x1 - x2
        let yy = y1 - y2
        if abs(xx) < toleranceDistence && abs(yy) < toleranceDistence { return }
        routeResultView(true)
        let hud = JTHUD(view: routeResultView).indeterminateWithText(LocalizableStrings.routeAnalysising)
        RouteSearchC.shareInstance.routeSearch(startX: x1, startY: y1, stopX: x2, stopY: y2) {
            [weak self]
            success, result, msg in
            hud.hide(animated: true)
            guard let this = self else { return }
            guard success, let r = result else {
                this.routeResultView(false)
                _ = JTHUD(view: this.view).textOnly(msg ?? LocalizableStrings.routeAnalysisFailed, removeOnHide: true, delayTimeIfAutoHide: TimeInterval(1.5))
                return
            }
            this.routeResult = r
            this.saveHistory(s: i, p: j)
            this.addSymbolLayerPolyline()
            this.centerShowSymbolLayerPolyline()
            this.showRouteResultView()

            this.routeResultView.backgroundColor = .white
        }
    }
}
extension RouteViewController {
    private func saveHistory(s: RoutePosition, p: RoutePosition) {
        _ = Data_RouteHistoryOperate.shareInstance.insert(startType: s.type, startName: s.name, startX: s.x, startY: s.y, stopType: p.type, stopName: p.name, stopX: p.x, stopY: p.y)
    }
    private func addSymbolLayerPolyline() {
        JTMapView.shareInstance.removeAllAdded()
        guard let r = routeResult, let routelatlin = r.routelatlon else { return }
        let subStrings = routelatlin.split(separator: ";")
        guard subStrings.count > 0 else { return }
        var points = [(Double,Double)]()
        for subString in subStrings {
            let subs = subString.split(separator: ",").map(Double.init)
            guard subs.count == 2 else { return }
            guard let x = subs[1], let y = subs[0] else { return }
            points.append((x,y))
        }
        JTMapView.shareInstance.addSymbolLayerPolyline(points: points)
    }
    private func centerShowSymbolLayerPolyline() {
        guard let r = routeResult, let center = r.center else { return }
        let subs = center.split(separator: ",").map(Double.init)
        guard subs.count == 2, let x = subs[0], let y = subs[1], let i = r.scale, let ii = Int(i), let scale = Tianditu_TileLevel(rawValue: ii) else { return }
        JTMapView.shareInstance.zoom(toScale: scale.scale, withCenter: AGSPoint(location: CLLocation(latitude: y, longitude: x)), animated: true)
    }
    private func showRouteResultView() {
        for view in routeResultView.subviews { view.removeFromSuperview() }
        if routeResult == nil { return }
        addTopView()
        addBottomView()
        
    }
    
}
extension RouteViewController {
    private func routeResultView(_ show: Bool) {
        if show {
            routeResultView.isHidden = false
            content.bringSubview(toFront: routeResultView)
        } else {
            routeResultView.isHidden = true
            content.sendSubview(toBack: routeResultView)
        }
    }
}
extension RouteViewController {
    private func mapView(show: Bool) {
        if show {
            setupMapView()
            routeMapViewView.isHidden = false
            routeHistoryTableView.isHidden = true
        } else {
            routeMapViewView.isHidden = true
            routeHistoryTableView.isHidden = false
        }
    }
}
class X: NSObject, SearchViewControllerDelegate {
    private let b: UISearchBar
    private let v: RouteViewController
    init(_ bar: UISearchBar, vc: RouteViewController) {
        b = bar
        v = vc
    }
    func searchPosition(_ searchViewController: SearchViewController, position: Object_Attribute) {
        guard let xx = position.x, let yy = position.y else { return }
        if b == v.startSearchBar {
            v.start = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
            v.start?.showPosition(b)
        } else if b == v.stopSearchBar {
            v.stop = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
            v.stop?.showPosition(b)
        }
        searchViewController.navigationController?.popViewController(animated: false)
        v.showRoute()
    }
    func searchText(_ searchViewController: SearchViewController, name: String) {
        let s = SearchContentViewController(name)
        s.searchContentViewControllerDelegate = self
        searchViewController.navigationController?.pushViewController(s, animated: false)
    }
    func myPlace(_ searchViewController: SearchViewController) {
        if b == v.startSearchBar {
            v.start = RoutePosition(type: .myPlace, x: 0, y: 0)
            v.start?.showPosition(b)
        } else if b == v.stopSearchBar {
            v.stop = RoutePosition(type: .myPlace, x: 0, y: 0)
            v.stop?.showPosition(b)
        }
        searchViewController.navigationController?.popViewController(animated: false)
        v.showRoute()
    }
}
extension X: SearchContentViewControllerDelegate {
    func didConfirmPostion(_ vc: SearchContentViewController, position: Object_Attribute) {
        guard let xx = position.x, let yy = position.y else { return }
        let navi = vc.navigationController
        if b == v.startSearchBar {
            v.start = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
            v.start?.showPosition(b)
        } else if b == v.stopSearchBar {
            v.stop = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
            v.stop?.showPosition(b)
        }
        navi?.popViewController(animated: false)
        navi?.popViewController(animated: false)
        v.showRoute()
    }
}

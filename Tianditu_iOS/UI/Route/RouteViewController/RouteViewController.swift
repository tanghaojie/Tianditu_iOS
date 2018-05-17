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
    private let routeResultViewHeight: CGFloat = 120
    var start: RoutePosition?
    var stop: RoutePosition?
    private let toleranceDistence = 0.02
    
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
        guard let i = start, let j = stop else { return }
        if i.type == .myPlace && j.type == .myPlace { return }
        let xx = i.x - j.x
        let yy = i.y - j.y
        if abs(xx) < toleranceDistence && abs(yy) < toleranceDistence { return }
        mapView(show: true)
        routeResultView(true)
        let hud = JTHUD(view: routeResultView).indeterminateWithText(LocalizableStrings.routeAnalysising)
        RouteSearchC.shareInstance.routeSearch(startX: i.x, startY: i.y, stopX: j.x, stopY: j.y) {
            success, result, msg in
            Thread.sleep(forTimeInterval: TimeInterval.init(5))
            hud.hide(animated: true)
            
        }
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

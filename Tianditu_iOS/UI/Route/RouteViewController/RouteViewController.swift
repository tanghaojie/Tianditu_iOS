//
//  RouteViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class RouteViewController: JTNavigationViewController {
    
    private let naviHeight: CGFloat = 100
    private let startSearchBar = JTSearchBar()
    private let startX: X
    private let stopX: X
    private let stopSearchBar = JTSearchBar()
    private let exchangeButton = UIButton()
    private let exchangeButtonWidth: CGFloat = 40
    private let exchangeButtonHeight: CGFloat = 80
    private let exchangeButtonMargin: CGFloat = 10
    private let routeHistoryTableView = RouteHistoryTableView()
    
    private var start: RoutePosition? {
        didSet { showRoute() }
    }
    private var stop: RoutePosition? {
        didSet { showRoute() }
    }
    
    init() {
        startX = X(startSearchBar, data: start)
        stopX = X(stopSearchBar, data: stop)
        super.init(naviHeight)
        setupUI()
        let i = RoutePosition(type: .myPlace, x: 0, y: 0)
        i.showPosition(startSearchBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        startX = X(startSearchBar, data: start)
        stopX = X(stopSearchBar, data: stop)
        super.init(coder: aDecoder)
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
        let i = RoutePosition(type: vm.startType, name: vm.startName, x: vm.startX, y: vm.startY)
        let j = RoutePosition(type: vm.stopType, name: vm.stopName, x: vm.stopX, y: vm.stopY)
        i.showPosition(startSearchBar)
        j.showPosition(stopSearchBar)
    }
}
extension RouteViewController {
    private func showRoute() {
        guard let i = start, let j = stop else { return }
        
    }
}

class X: NSObject, SearchViewControllerDelegate {
    private let b: UISearchBar
    private var d: RoutePosition?
    init(_ bar: UISearchBar, data: RoutePosition?) {
        b = bar
        d = data
    }
    func searchPosition(_ searchViewController: SearchViewController, position: Object_Attribute) {
        guard let xx = position.x, let yy = position.y else { return }
        d = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
        d?.showPosition(b)
        searchViewController.navigationController?.popViewController(animated: false)
    }
    func searchText(_ searchViewController: SearchViewController, name: String) {
        let s = SearchContentViewController(name)
        s.searchContentViewControllerDelegate = self
        searchViewController.navigationController?.pushViewController(s, animated: false)
    }
    func myPlace(_ searchViewController: SearchViewController) {
        d = RoutePosition(type: .myPlace, x: 0, y: 0)
        d?.showPosition(b)
        searchViewController.navigationController?.popViewController(animated: false)
    }
}
extension X: SearchContentViewControllerDelegate {
    func didConfirmPostion(_ vc: SearchContentViewController, position: Object_Attribute) {
        guard let xx = position.x, let yy = position.y else { return }
        let navi = vc.navigationController
        d = RoutePosition(type: .coordinate, name: position.name, x: xx, y: yy)
        d?.showPosition(b)
        navi?.popViewController(animated: false)
        navi?.popViewController(animated: false)
    }
}

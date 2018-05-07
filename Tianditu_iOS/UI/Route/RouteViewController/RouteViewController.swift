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
    private let stopSearchBar = JTSearchBar()
    //private let searchBarHeight: CGFloat = 40
    private let exchangeButton = UIButton()
    private let exchangeButtonWidth: CGFloat = 40
    private let exchangeButtonHeight: CGFloat = 80
    private let exchangeButtonMargin: CGFloat = 10
    private let routeHistoryTableView = RouteHistoryTableView()
    
    fileprivate var start: Object_Attribute?
    private var stop: Object_Attribute?
    
    init() {
        super.init(naviHeight)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
        navigationContent.addSubview(startSearchBar)
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
        navigationContent.addSubview(stopSearchBar)
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
            s.searchDelegate = self
        } else if searchBar == stopSearchBar {
            s.searchDelegate = self
        } else { return false }
        navigationController?.pushViewController(s, animated: false)
        return false
    }
}
extension RouteViewController: SearchViewControllerDelegate {
    
}
extension RouteViewController: JTRouteHistoryTableViewDelegate {
    func didSelectedHistory(vm: RouteHistoryTableViewCellVM) {
        
    }
}

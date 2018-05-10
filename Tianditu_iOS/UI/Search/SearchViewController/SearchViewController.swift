//
//  SearchViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchViewController: JTNavigationViewController {
    
    private let searchButton = UIButton()
    private let jtSearchBar = JTSearchBar()
    private let mainPage = UIView()
    private let locationView = SearchTopLocationView.loadFromNib()
    private let locationViewHeight: CGFloat
    private let historyTableView = SearchHistoryTableView()
    private let contentTableView = SearchContentTableView()
    weak var searchDelegate: SearchViewControllerDelegate?
    
    init(_ showLocationView: Bool = false) {
        if showLocationView { locationViewHeight = 60 }
        else {
            locationView.isHidden = true
            locationViewHeight = 0 }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.locationViewHeight = 0
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyTableView.reloadHistory()
    }
}
extension SearchViewController {
    private func setupUI() {
        setupSearchButton()
        setupJTSearchBar()
        setupMainPage()
        setupLocationView()
        setupSearchHistoryTableView()
        setupSearchContentTableView()
    }
    private func setupJTNavigation() {
        view.backgroundColor = .white
    }
    private func setupSearchButton() {
        let btnAspectRatio: CGFloat = 1.5
        let width = navigationHeight * btnAspectRatio
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setImage(Assets.search_zh_cn, for: .normal)
        navigationContent.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            searchButton.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: width),
            ])
        searchButton.addTarget(self, action: #selector(searchTouchUpInside), for: .touchUpInside)
    }
    private func setupJTSearchBar() {
        jtSearchBar.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(jtSearchBar)
        NSLayoutConstraint.activate([
            jtSearchBar.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            jtSearchBar.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            jtSearchBar.leadingAnchor.constraint(equalTo: navigationContent.leadingAnchor),
            jtSearchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            ])
        jtSearchBar.delegate = self
    }
    private func setupMainPage() {
        mainPage.translatesAutoresizingMaskIntoConstraints = false
        mainPage.backgroundColor = .red
        content.addSubview(mainPage)
        NSLayoutConstraint.activate([
            mainPage.topAnchor.constraint(equalTo: content.topAnchor),
            mainPage.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            mainPage.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            mainPage.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupLocationView() {
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.delegate = self
        mainPage.addSubview(locationView)
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: mainPage.topAnchor),
            locationView.heightAnchor.constraint(equalToConstant: locationViewHeight),
            locationView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
    }
    private func setupSearchHistoryTableView() {
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(historyTableView)
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
        historyTableView.jtDelegate = self
    }
    private func setupSearchContentTableView() {
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: content.topAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
        contentTableView.isHidden = true
        contentTableView.jtDelegate = self
    }
    private func showContent(text: String) {
        mainPage.isHidden = true
        contentTableView.isHidden = false
        contentTableView.nameSearch(text: text)
    }
    private func showHistory() {
        jtSearchBar.text = nil
        contentTableView.isHidden = true
        mainPage.isHidden = false
        contentTableView.renew()
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContent(text: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
extension SearchViewController {
    @objc private func searchTouchUpInside() {
        search()
    }
}
extension SearchViewController {
    private func searchContent(text: String) {
        if text == "" || text.trimmingCharacters(in: .whitespaces) == "" {
            showHistory()
            return
        }
        showContent(text: text)
    }
    private func search() {
        guard let t = jtSearchBar.text else { return }
        let text = t.trimmingCharacters(in: .whitespaces)
        if text == "" { return }
        Data_SearchHistoryOperate.shareInstance.deleteByName(name: text)
        _ = Data_SearchHistoryOperate.shareInstance.insert(name: text)
        historyTableView.reloadHistory()
        showHistory()
        searchText(name: text)
    }
}
extension SearchViewController: JTSearchHistoryTableViewDelegate {
    
    func didSelectedHistory(vm: SearchHistoryTableViewCellVM) {
        guard let data = vm.data else { return }
        guard let n = data.name else { return }
        Data_SearchHistoryOperate.shareInstance.deleteByName(name: n)
        if let id = data.uuidStr {
            Data_SearchHistoryOperate.shareInstance.deleteByUUID(uuid: id)
        }
        if vm.nameOnly {
            _ = Data_SearchHistoryOperate.shareInstance.insert(name: n)
            historyTableView.reloadHistory()
            searchText(name: n)
        } else {
            var df: Int16 = 0
            if let xx = data.datafrom { df = Int16(xx) }
            var dd: Int64 = 0
            if let aa = data.id { dd = Int64(aa) }
            _ = Data_SearchHistoryOperate.shareInstance.insert(address: data.address, county: data.county, datafrom: df, id: dd, imageAddress: data.imageAddress, name: n, phone: data.phone, region: data.region, typeStr: data.typeStr, x: data.x, y: data.y)
            historyTableView.reloadHistory()
            searchPosition(position: data)
        }
    }
}
extension SearchViewController: JTSearchContentTableViewDelegate {
    func didSelectedContent(vm: SearchContentTableViewCellVM) {
        guard let data = vm.data else { return }
        guard let n = data.name else { return }
        Data_SearchHistoryOperate.shareInstance.deleteByName(name: n)
        if let id = data.uuidStr {
            Data_SearchHistoryOperate.shareInstance.deleteByUUID(uuid: id)
        }
        var df: Int16 = 0
        if let xx = data.datafrom { df = Int16(xx) }
        var dd: Int64 = 0
        if let aa = data.id { dd = Int64(aa) }
        _ = Data_SearchHistoryOperate.shareInstance.insert(address: data.address, county: data.county, datafrom: df, id: dd, imageAddress: data.imageAddress, name: n, phone: data.phone, region: data.region, typeStr: data.typeStr, x: data.x, y: data.y)
        historyTableView.reloadHistory()
        showHistory()
        searchPosition(position: data)
    }
}
extension SearchViewController {
    private func searchPosition(position: Object_Attribute) {
        searchDelegate?.searchPosition(self, position: position)
    }
    private func searchText(name: String) {
        searchDelegate?.searchText(self, name: name)
    }
}
extension SearchViewController: SearchTopLocationViewDelegate {
    func location(_ atMyPlace: SearchTopLocationView) {
        searchDelegate?.myPlace(self)
    }
}
protocol SearchViewControllerDelegate: NSObjectProtocol {
    func searchPosition(_ searchViewController: SearchViewController, position: Object_Attribute)
    func searchText(_ searchViewController: SearchViewController, name: String)
    func myPlace(_ searchViewController: SearchViewController)
}
extension SearchViewControllerDelegate {
    func searchPosition(_ searchViewController: SearchViewController, position: Object_Attribute) {}
    func searchText(_ searchViewController: SearchViewController, name: String) {}
    func myPlace(_ searchViewController: SearchViewController) {}
}

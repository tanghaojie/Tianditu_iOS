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
    private let historyTableView = SearchHistoryTableView()
    private let contentTableView = SearchContentTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchButton.backgroundColor = .red
        historyTableView.backgroundColor = .blue
    }

}
extension SearchViewController {
    private func setupUI() {
        setupSearchButton()
        setupJTSearchBar()
        setupSearchHistoryTableView()
        setupSearchContentTableView()
    }
    private func setupSearchButton() {
        let btnAspectRatio: CGFloat = 1.5
        let width = navigationHeight * btnAspectRatio
        searchButton.translatesAutoresizingMaskIntoConstraints = false
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
    private func setupSearchHistoryTableView() {
        historyTableView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(historyTableView)
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: content.topAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
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
            contentTableView.isHidden = true
            historyTableView.isHidden = false
            contentTableView.renew()
            return
        }
        historyTableView.isHidden = true
        contentTableView.isHidden = false
        contentTableView.nameSearch(text: text)
    }
    
    private func search() {
        
    }
    
   
}

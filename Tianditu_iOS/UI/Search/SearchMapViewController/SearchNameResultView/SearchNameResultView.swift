//
//  SearchMultiResultView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class SearchNameResultView: UIView {
    
    private let searchContentTableView = SearchContentTableView()
    private var text: String = ""
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
extension SearchNameResultView {
    func nameSearch(_ name: String) {
        text = name
        searchContentTableView.nameSearch(text: text)
    }
}
extension SearchNameResultView {
    private func setupUI() {
        setupTableView()
    }
    private func setupTableView() {
        searchContentTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchContentTableView)
        NSLayoutConstraint.activate([
            searchContentTableView.topAnchor.constraint(equalTo: topAnchor),
            searchContentTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchContentTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchContentTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    }
}

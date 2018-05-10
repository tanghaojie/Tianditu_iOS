//
//  SearchContentViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/9.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class SearchContentViewController: JTNavigationViewController {
    
    weak var searchContentViewControllerDelegate: SearchContentViewControllerDelegate?
    private let name: String
    private let tableView = SearchContentTableView()
    
    init(_ name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension SearchContentViewController {
    private func setupUI() {
        setupTitle()
        setupSearchContentTableView()
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.confirmPosition
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 130),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    private func setupSearchContentTableView() {
        tableView.jtDelegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.nameSearch(text: name)
        content.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: content.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
}
extension SearchContentViewController: JTSearchContentTableViewDelegate {
    func didSelectedContent(vm: SearchContentTableViewCellVM) {
        guard let d = vm.data else { return }
        searchContentViewControllerDelegate?.didConfirmPostion(self, position: d)
    }
}
protocol SearchContentViewControllerDelegate: NSObjectProtocol {
    func didConfirmPostion(_ vc: SearchContentViewController, position: Object_Attribute)
}

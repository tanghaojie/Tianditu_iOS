//
//  SearchHistoryTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchHistoryTableView: UITableView {

    private let cellReuseIdentifier = "searchHistoryTableViewCellReuseIdentifier"
    private var cellVMs: [SearchHistoryTableViewCellVM] = [SearchHistoryTableViewCellVM]()
    private let footerHeight: CGFloat = 60
    private let headerHeight: CGFloat = 10
    weak var jtDelegate: JTSearchHistoryTableViewDelegate?
    
    init(cellVMs: [SearchHistoryTableViewCellVM]? = nil) {
        if let vms = cellVMs {
            self.cellVMs = vms
        }
        super.init(frame: CGRect.zero, style: .plain)
        setupUI()
        reloadHistory()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
extension SearchHistoryTableView {
    func append(vms: [SearchHistoryTableViewCellVM]) {
        cellVMs.append(contentsOf: vms)
    }
}
extension SearchHistoryTableView {
    private func setupUI() {
        setupTableView()
    }
    private func setupTableView() {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bounces = true
        alwaysBounceVertical = true
        alwaysBounceHorizontal = false
        scrollsToTop = true
        keyboardDismissMode = .onDrag
        allowsSelection = true
        separatorStyle = .none
        backgroundColor = UIColor(r: 233, g: 233, b: 233)
        estimatedRowHeight = 90
        rowHeight = UITableViewAutomaticDimension
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: headerHeight))
        view.isUserInteractionEnabled = false
        tableHeaderView = view
        dataSource = self
        delegate = self
    }
    private func removeFooterView() {
        if let s = tableFooterView?.subviews {
            for ss in s {
                ss.removeFromSuperview()
            }
        }
        tableFooterView = nil
    }
    private func showFooterView() {
        removeFooterView()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: footerHeight))
        view.isUserInteractionEnabled = true
        tableFooterView = view
        let b = UIButton()
        b.backgroundColor = .white
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(UIColor(r: 160, g: 160, b: 160), for: .normal)
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: Global_Common.shareInstance.ScreenWidth, height: 1)
        layer.backgroundColor = UIColor(r: 233, g: 233, b: 233).cgColor
        b.layer.addSublayer(layer)
        view.addSubview(b)
        b.setTitle(LocalizableStrings.clearHistory, for: .normal)
        NSLayoutConstraint.activate([
            b.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            b.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            b.topAnchor.constraint(equalTo: view.topAnchor),
            b.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        b.addTarget(self, action: #selector(clearHistoryTouchUpInside), for: .touchUpInside)
        b.isUserInteractionEnabled = true
    }
}
extension SearchHistoryTableView {
    @objc private func clearHistoryTouchUpInside() {
        _ = Data_SearchHistoryOperate.shareInstance.clear()
        reloadHistory()
    }
}
extension SearchHistoryTableView {
    func reloadHistory() {
        cellVMs.removeAll()
        removeFooterView()
        reloadData()
        guard let a = Data_SearchHistoryOperate.shareInstance.getAll(), a.count > 0 else {
            tableFooterView = UIView()
            return
        }
        for i in a.reversed() {
            let vm = SearchHistoryTableViewCellVM(i.attribute)
            cellVMs.append(vm)
        }
        showFooterView()
        reloadData()
    }
}
extension SearchHistoryTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cellVMs.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = SearchHistoryTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? SearchHistoryTableViewCell {
                let vm = cellVMs[indexPath.row]
                c.set(vm: vm)
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = cellVMs[indexPath.row]
        jtDelegate?.didSelectedHistory(vm: vm)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? { return LocalizableStrings.delete }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard index < cellVMs.count else { return }
        let vm = cellVMs[index]
        guard let data = vm.data, let uuid = data.uuidStr else { return }
        _ = Data_SearchHistoryOperate.shareInstance.deleteByUUID(uuid: uuid)
        reloadHistory()
    }
}
protocol JTSearchHistoryTableViewDelegate: NSObjectProtocol {
    func didSelectedHistory(vm: SearchHistoryTableViewCellVM)
}

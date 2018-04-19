//
//  SearchContentTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh

class SearchContentTableView: UITableView {
    
    private let cellReuseIdentifier = "searchHistoryTableViewCellReuseIdentifier"
    private var cellVMs: [SearchContentTableViewCellVM] = [SearchContentTableViewCellVM]()
    private let pagesize = 10
    private var pagenum = 1
    private var searchText = ""
    
    init(cellVMs: [SearchContentTableViewCellVM]? = nil) {
        if let vms = cellVMs {
            self.cellVMs = vms
        }
        super.init(frame: CGRect.zero, style: .plain)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bounces = true
        alwaysBounceVertical = true
        alwaysBounceHorizontal = false
        scrollsToTop = true
        keyboardDismissMode = .onDrag
        allowsSelection = true
        separatorStyle = .singleLine
        estimatedRowHeight = 50
        rowHeight = UITableViewAutomaticDimension
        
        let footer = MJRefreshAutoGifFooter()
        footer.backgroundColor = .white
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.setTitle("", for: .idle)
        footer.setTitle("", for: .pulling)
        footer.setTitle("", for: .refreshing)
        footer.setTitle("", for: .noMoreData)
        mj_footer = footer

        dataSource = self
        
        renew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
extension SearchContentTableView {
    
    func nameSearch(text: String) {
        renew()
        searchText = text
        searchData()
    }

    func renew() {
        searchText = ""
        pagenum = 1
        mj_footer.endRefreshing()
        cellVMs.removeAll()
        reloadData()
    }

}
extension SearchContentTableView {
    @objc private func footerRefresh() {
        if mj_footer.state == .noMoreData { return }
        searchData()
    }
}
extension SearchContentTableView {
    
    private func searchData() {
        if searchText == "" || searchText.trimmingCharacters(in: .whitespaces) == "" { return }
        let end = pagenum * pagesize
        let start = end - pagesize
        Search_NameSearchC.shareInstance.NameSearch(text: searchText, start: start, end: end) {
            [weak self]
            result, r, _ in
            guard result else { return }
            guard let rr = r, let s = rr.success, s, let ns = rr.message, let fs = ns.features else { return }
            guard fs.count > 0 else {
                self?.mj_footer.state = .noMoreData
                return
            }
            for f in fs {
                guard let a = f.attributes else { continue }
                let at = Object_Attribute(data: a)
                let vm = SearchContentTableViewCellVM(at)
                self?.append(vm)
            }
            self?.pagenum += 1
            self?.mj_footer.endRefreshing()
            self?.reloadData()
        }
    }
    
    private func append(_ vm: SearchContentTableViewCellVM) {
        cellVMs.append(vm)
    }
}
extension SearchContentTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = SearchContentTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? SearchContentTableViewCell {
                let vm = cellVMs[indexPath.row]
                c.set(vm: vm)
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
}


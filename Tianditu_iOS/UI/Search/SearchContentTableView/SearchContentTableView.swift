//
//  SearchContentTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import MJRefresh
import JTFramework

class SearchContentTableView: UITableView {
    
    private let cellReuseIdentifier = "searchHistoryTableViewCellReuseIdentifier"
    private var cellVMs: [SearchContentTableViewCellVM] = [SearchContentTableViewCellVM]()
    private let pagesize = 10
    private var pagenum = 1
    private var searchText = ""
    private var searchType = Tianditu_NameSearchType.unknown
    private var type: SearchType? = nil
    private var envelope: Object_SearchEnvelope? = nil
    private var first = true
    weak var jtDelegate: JTSearchContentTableViewDelegate?
    
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
        delegate = self
        separatorStyle = .none
        estimatedRowHeight = 90
        rowHeight = UITableView.automaticDimension
        backgroundColor = UIColor(r: 233, g: 233, b: 233)
        
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
    
    var dataNumber: Int {
        get { return cellVMs.count }
    }
    var positions: [Object_Attribute] {
        get {
            var x = [Object_Attribute]()
            if cellVMs.count > 0 {
                for vm in cellVMs {
                    guard let y = vm.data else { continue }
                    x.append(y)
                }
            }
            return x
        }
    }
}
extension SearchContentTableView {
    
    func nameSearch(text: String, handler: ((Bool) -> Void)? = nil) {
        renew()
        type = .name
        searchText = text
        searchNameData(handler)
    }
    
    func typeSearch(type: Tianditu_NameSearchType, envelope: Object_SearchEnvelope? = nil, handler: ((Bool) -> Void)? = nil) {
        renew()
        self.type = .type
        self.envelope = envelope
        searchType = type
        searchTypeData(handler)
    }

    func renew() {
        type = nil
        envelope = nil
        searchText = ""
        pagenum = 1
        first = true
        mj_footer?.endRefreshing()
        cellVMs.removeAll()
        reloadData()
    }

}
extension SearchContentTableView {
    @objc private func footerRefresh() {
        if mj_footer?.state == .noMoreData { return }
        if type == .name {
            searchNameData()
        } else if type == .type {
            searchTypeData()
        }
    }
}
extension SearchContentTableView {
    
    private func searchNameData(_ handler: ((Bool) -> Void)? = nil) {
        if searchText == "" || searchText.trimmingCharacters(in: .whitespaces) == "" { return }
        let end = pagenum * pagesize
        let start = end - pagesize
        Search_NameSearchC.shareInstance.nameSearch(text: searchText, start: start, end: end) {
            [weak self]
            result, r, _ in
            guard result else {
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(false)
                }
                return
            }
            guard let rr = r, let s = rr.success, s, let ns = rr.message, let fs = ns.features else {
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(false)
                }
                return
            }
            guard fs.count > 0 else {
                self?.mj_footer?.state = .noMoreData
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(true)
                }
                return
            }
            for f in fs {
                guard let a = f.attributes else { continue }
                let at = Object_Attribute(data: a)
                let vm = SearchContentTableViewCellVM(at)
                self?.append(vm)
            }
            self?.pagenum += 1
            self?.mj_footer?.endRefreshing()
            self?.reloadData()
            if let s = self, s.first, let h = handler {
                s.first = false
                h(true)
            }
        }
    }
    private func searchTypeData(_ handler: ((Bool) -> Void)? = nil) {
        if searchType == .unknown { return }
        let end = pagenum * pagesize
        let start = end - pagesize
        Search_NameSearchC.shareInstance.typeSearch(type: searchType, start: start, end: end, envelope: envelope) {
            [weak self]
            result, r, _ in
            guard result else {
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(false)
                }
                return
            }
            guard let rr = r, let s = rr.success, s, let ns = rr.message, let fs = ns.features else {
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(false)
                }
                return
            }
            guard fs.count > 0 else {
                self?.mj_footer?.state = .noMoreData
                if let s = self, s.first, let h = handler {
                    s.first = false
                    h(true)
                }
                return
            }
            for f in fs {
                guard let a = f.attributes else { continue }
                let at = Object_Attribute(data: a)
                let vm = SearchContentTableViewCellVM(at)
                self?.append(vm)
            }
            self?.pagenum += 1
            self?.mj_footer?.endRefreshing()
            self?.reloadData()
            if let s = self, s.first, let h = handler {
                s.first = false
                h(true)
            }
        }
    }
    
    private func append(_ vm: SearchContentTableViewCellVM) {
        cellVMs.append(vm)
    }
}
extension SearchContentTableView: UITableViewDataSource, UITableViewDelegate {
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = cellVMs[indexPath.row]
        jtDelegate?.didSelectedContent(vm: vm)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        jtDelegate?.scrollViewDidScroll(scrollView)
    }
}
protocol JTSearchContentTableViewDelegate: NSObjectProtocol {
    func didSelectedContent(vm: SearchContentTableViewCellVM)
}
extension JTSearchContentTableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}
extension SearchContentTableView {
    private enum SearchType {
        case name
        case type
    }
}

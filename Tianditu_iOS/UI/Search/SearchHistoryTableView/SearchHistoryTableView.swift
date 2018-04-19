//
//  SearchHistoryTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class SearchHistoryTableView: UITableView {

    private let cellReuseIdentifier = "searchContentTableViewCellReuseIdentifier"
    
    private var cellVMs: [SearchContentTableViewCellVM] = [SearchContentTableViewCellVM]()
    
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
        separatorStyle = .none
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
extension SearchHistoryTableView {
    func append(vms: [SearchContentTableViewCellVM]) {
        cellVMs.append(contentsOf: vms)
    }
}
extension SearchHistoryTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count > 0 ? cellVMs.count + 1 : 0
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

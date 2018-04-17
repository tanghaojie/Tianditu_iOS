//
//  FunctionTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class FunctionTableView: UITableView {
    
    private let cellReuseIdentifier = "functionTableViewCellReuseIdentifier"
    
    private var cellVMs: [FunctionTableViewCellVM] = [FunctionTableViewCellVM]()

    init(cellVMs: [FunctionTableViewCellVM]? = nil) {
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
extension FunctionTableView {
    func append(vms: [FunctionTableViewCellVM]) {
        cellVMs.append(contentsOf: vms)
    }
}
extension FunctionTableView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = FunctionTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? FunctionTableViewCell {
                let vm = cellVMs[indexPath.row]
                c.set(vm: vm)
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
}

//
//  RouteResultDetailTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class RouteResultDetailTableView: UITableView {
    private let cellReuseIdentifier = "routeResultDetailTableViewCellReuseIdentifier"
    private var cellVMs: [RouteResultDetailTableViewCellVM] = [RouteResultDetailTableViewCellVM]()
    private let start: String
    private let end: String
    private let headerFooterHeight: CGFloat = 50
    private let imageViewSize: CGFloat = 40
    
    init(start: String, end: String, cellVMs: [RouteResultDetailTableViewCellVM]? = nil) {
        self.start = start
        self.end = end
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
        estimatedRowHeight = 30
        rowHeight = UITableViewAutomaticDimension
        backgroundColor = .white

        dataSource = self
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        start = ""
        end = ""
        super.init(coder: aDecoder)
    }
}
extension RouteResultDetailTableView {
    private func setupUI() {
        setupHeader()
        setupFooter()
    }
    private func setupHeader() {
        let h = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: headerFooterHeight))
        h.backgroundColor = .white
        tableHeaderView = h
        let margin: CGFloat = (headerFooterHeight - imageViewSize) / 2
        let imageView = UIImageView(frame: CGRect(x: margin, y: margin, width: imageViewSize, height: imageViewSize))
        imageView.image = Assets.start
        h.addSubview(imageView)
        let x = margin + imageViewSize + margin
        let w = Global_Common.shareInstance.ScreenWidth - x - margin
        let hh = headerFooterHeight - margin - margin
        let label = UILabel(frame: CGRect(x: x, y: margin, width: w, height: hh))
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "\(LocalizableStrings.from) \(start) \(LocalizableStrings.startOff)"
        h.addSubview(label)
    }
    private func setupFooter() {
        let f = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: headerFooterHeight))
        f.backgroundColor = .white
        tableFooterView = f
        let margin: CGFloat = (headerFooterHeight - imageViewSize) / 2
        let imageView = UIImageView(frame: CGRect(x: margin, y: margin, width: imageViewSize, height: imageViewSize))
        imageView.image = Assets.end
        f.addSubview(imageView)
        let x = margin + imageViewSize + margin
        let w = Global_Common.shareInstance.ScreenWidth - x - margin
        let hh = headerFooterHeight - margin - margin
        let label = UILabel(frame: CGRect(x: x, y: margin, width: w, height: hh))
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "\(LocalizableStrings.arrive) \(end)"
        f.addSubview(label)
    }
}
extension RouteResultDetailTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = RouteResultDetailTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? RouteResultDetailTableViewCell {
                let vm = cellVMs[indexPath.row]
                c.set(vm: vm)
            }
            cell?.selectionStyle = .none
        }
        return cell!
    }
}


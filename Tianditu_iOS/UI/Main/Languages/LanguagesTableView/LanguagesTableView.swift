//
//  LanguagesTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/13.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class LanguagesTableView: UITableView {
    private let cellReuseIdentifier = "languagesTableViewCellReuseIdentifier"
    private var cellVMs: [LanguagesTableViewCellVM] = [LanguagesTableViewCellVM]()
    weak var jtDelegate: JTLanguagesTableViewDelegate?
    var selectedIndex: IndexPath?
    private var currentLanguage: JTLanguages?
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension LanguagesTableView {
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
        estimatedRowHeight = 50
        rowHeight = UITableView.automaticDimension
        dataSource = self
        delegate = self
    }
}
extension LanguagesTableView {
    func append(VMs: [LanguagesTableViewCellVM]) {
        cellVMs.append(contentsOf: VMs)
        reloadData()
    }
    func setTick(index: IndexPath) {
        selectedIndex = index
        reloadData()
    }
    func get(index: IndexPath) -> LanguagesTableViewCellVM {
        return cellVMs[index.row]
    }
    func reloadLanguage() {
        var currentLanguage = JTLanguages.getCurrentUserLanguage()
        if currentLanguage == nil { currentLanguage = JTLanguages.getAppleLanguage() }
        for index in cellVMs.enumerated() {
            if index.element.data == currentLanguage { selectedIndex = IndexPath(row: index.offset, section: 0) }
        }
        reloadData()
    }
}
extension LanguagesTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = LanguagesTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? LanguagesTableViewCell { c.set(vm: cellVMs[indexPath.row]) }
            cell?.selectionStyle = .none
        }
        if let c = cell as? LanguagesTableViewCell {
            if indexPath == selectedIndex { c.setRightImage(img: Assets.tick) }
            else { c.setRightImage() }
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jtDelegate?.didSelectLanguage(indexPath: indexPath, vm: cellVMs[indexPath.row])
    }
}
protocol JTLanguagesTableViewDelegate: NSObjectProtocol {
    func didSelectLanguage(indexPath: IndexPath, vm: LanguagesTableViewCellVM)
}

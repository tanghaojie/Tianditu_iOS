//
//  FavoritesTableView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class FavoritesTableView: UITableView {
    private let cellReuseIdentifier = "favoritesTableViewCellReuseIdentifier"
    private var cellVMs: [FavoritesTableViewCellVM] = [FavoritesTableViewCellVM]()
    weak var jtDelegate: JTFavoritesTableViewDelegate?
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setupUI()
        reload()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension FavoritesTableView {
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
        rowHeight = UITableView.automaticDimension
        allowsMultipleSelectionDuringEditing = true
        dataSource = self
        delegate = self
    }
}
extension FavoritesTableView {
    func reload() {
        cellVMs.removeAll()
        guard let a = Data_FavoriteOperate.shareInstance.getAll(), a.count > 0 else { return }
        for i in a {
            cellVMs.append(FavoritesTableViewCellVM(data: i))
        }
        reloadData()
    }
    func deleteSelectedRows() -> Bool {
        guard let indexPaths = indexPathsForSelectedRows, indexPaths.count > 0 else { return false }
        for indexPath in indexPaths {
            let vm = cellVMs[indexPath.row]
            if let uuid = vm.uuidStr { _ = Data_FavoriteOperate.shareInstance.deleteByUUID(uuid: uuid) }
        }
        reload()
        return true
    }
    func deleteRow(vm: FavoritesTableViewCellVM) {
        guard let uuid = vm.uuidStr else { return }
        _ = Data_FavoriteOperate.shareInstance.deleteByUUID(uuid: uuid)
        reload()
    }
}
extension FavoritesTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVMs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            cell = FavoritesTableViewCell(reuseIdentifier: cellReuseIdentifier)
            if let c = cell as? FavoritesTableViewCell { c.set(vm: cellVMs[indexPath.row]) }
            cell?.selectionStyle = .default
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? { return LocalizableStrings.delete }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard index < cellVMs.count else { return }
        let vm = cellVMs[index]
        guard let uuid = vm.uuidStr else { return }
        _ = Data_FavoriteOperate.shareInstance.deleteByUUID(uuid: uuid)
        reload()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditing { return }
        jtDelegate?.didSelectFavorite(vm: cellVMs[indexPath.row])
        deselectRow(at: indexPath, animated: false)
    }
}
protocol JTFavoritesTableViewDelegate: NSObjectProtocol {
    func didSelectFavorite(vm: FavoritesTableViewCellVM)
}

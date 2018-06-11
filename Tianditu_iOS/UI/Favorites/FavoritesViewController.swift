//
//  FavoritesViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class FavoritesViewController: JTNavigationViewController {
    private var deleteView: UIView?
    private let mainPage = UIView()
    private let multiSelectButton = UIButton()
    private let favoritesTableView = FavoritesTableView()
    private let deleteViewHeight: CGFloat = 50
    private let deleteButtonWidth: CGFloat = 150

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesTableView.reload()
    }
}
extension FavoritesViewController {
    private func setupUI() {
        setupTitle()
        setupMultiSelectButton()
        setupMainPage()
        setupFavoritesTableView()
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.favor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 63),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    private func setupMultiSelectButton() {
        let btnAspectRatio: CGFloat = 1.5
        let width = navigationHeight * btnAspectRatio
        multiSelectButton.translatesAutoresizingMaskIntoConstraints = false
        multiSelectButton.tag = 0
        multiSelectButton.setTitleColor(UIColor.init(r: 0, g: 122, b: 255), for: .normal)
        multiSelectButton.setTitle(LocalizableStrings.multiSelect, for: .normal)
        navigationContent.addSubview(multiSelectButton)
        NSLayoutConstraint.activate([
            multiSelectButton.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            multiSelectButton.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            multiSelectButton.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor),
            multiSelectButton.widthAnchor.constraint(equalToConstant: width),
            ])
        multiSelectButton.addTarget(self, action: #selector(multiSelectTouchUpInside), for: .touchUpInside)
    }
    private func setupMainPage() {
        mainPage.translatesAutoresizingMaskIntoConstraints = false
        mainPage.backgroundColor = .white
        content.addSubview(mainPage)
        NSLayoutConstraint.activate([
            mainPage.topAnchor.constraint(equalTo: content.topAnchor),
            mainPage.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            mainPage.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            mainPage.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupFavoritesTableView() {
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.jtDelegate = self
        mainPage.addSubview(favoritesTableView)
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: mainPage.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
    }
    private func setupDeleteView(){
        if deleteView == nil { deleteView = UIView() }
        guard let d = deleteView else { return }
        d.translatesAutoresizingMaskIntoConstraints = false
        d.backgroundColor = .white
        mainPage.addSubview(d)
        NSLayoutConstraint.activate([
            d.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            d.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            d.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            d.heightAnchor.constraint(equalToConstant: deleteViewHeight),
            ])
        mainPage.bringSubview(toFront: d)
        setupDeleteButton(view: d)
    }
    private func setupDeleteButton(view: UIView) {
        let deleteButton = UIButton()
        deleteButton.addTarget(self, action: #selector(deleteButtonTouchUpInside), for: .touchUpInside)
        deleteButton.setImage(Assets.delete, for: .normal)
        deleteButton.setTitle(LocalizableStrings.delete, for: .normal)
        deleteButton.setTitleColor(UIColor.init(r: 255, g: 73, b: 73), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: deleteButtonWidth),
            ])
    }
    private func showDeleteView() {
        setupDeleteView()
        guard let d = deleteView else { return }
        d.layoutIfNeeded()
        d.transform = CGAffineTransform(translationX: 0, y: d.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            d.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    private func removeDeleteView() {
        guard let d = deleteView else { return }
        d.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            d.transform = CGAffineTransform(translationX: 0, y: d.frame.height)
        }) {
            finish in
            if finish { d.removeFromSuperview() }
        }
    }
}
extension FavoritesViewController {
    @objc private func deleteButtonTouchUpInside() {
        if favoritesTableView.deleteSelectedRows() { multiSelectTouchUpInside() }
    }
    @objc private func multiSelectTouchUpInside() {
        let tag = multiSelectButton.tag
        if tag == 0 {
            favoritesTableView.setEditing(true, animated: true)
            multiSelectButton.setTitle(LocalizableStrings.cancel, for: .normal)
            multiSelectButton.tag = 1
            showDeleteView()
        } else {
            favoritesTableView.setEditing(false, animated: true)
            multiSelectButton.setTitle(LocalizableStrings.multiSelect, for: .normal)
            multiSelectButton.tag = 0
            removeDeleteView()
        }
    }
}
extension FavoritesViewController: JTFavoritesTableViewDelegate {
    func didSelectFavorite(vm: FavoritesTableViewCellVM) {
        guard let id = vm.id, let x = vm.x, let y = vm.y else {
            favoritesTableView.deleteRow(vm: vm)
            return
        }
        var df: Int = 0
        if let x = vm.datafrom { df = Int(x) }
        let o = Object_Attribute(id: Int(id), x: x, y: y, name: vm.name, typeStr: vm.typeStr, region: vm.region, county: vm.county, phone: vm.phone, address: vm.address, datafrom: df, imageAddress: vm.imageAddress)
        let svc = SearchMapViewController(position: o, showSearchBar: false, titleText: vm.name)
        navigationController?.pushViewController(svc, animated: false)
    }
}


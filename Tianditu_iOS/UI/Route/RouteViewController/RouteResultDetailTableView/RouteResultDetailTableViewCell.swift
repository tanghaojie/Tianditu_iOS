//
//  RouteResultDetailTableViewCell.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class RouteResultDetailTableViewCell: UITableViewCell {
    private let fullView = UIView()
    private let label = UILabel()
    private let labelTopBottomMargin: CGFloat = 20
    private let labelLeftRightMargin: CGFloat = 22
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
extension RouteResultDetailTableViewCell {
    private func setupUI() {
        setupFull()
        setupLabel()
    }
    private func setupFull() {
        fullView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fullView)
        fullView.backgroundColor = .white
        NSLayoutConstraint.activate([
            fullView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fullView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            fullView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
    private func setupLabel() {
        label.textAlignment = .left
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: labelLeftRightMargin),
            label.topAnchor.constraint(equalTo: fullView.topAnchor, constant: labelTopBottomMargin),
            label.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: -labelLeftRightMargin),
            ])
    }
    
}
extension RouteResultDetailTableViewCell {
    func set(vm: RouteResultDetailTableViewCellVM) {
        label.text = vm.text
    }
}

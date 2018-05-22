//
//  SearchHistoryTableViewCell.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/7.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class RouteHistoryTableViewCell: UITableViewCell {
    
    private let fullView = UIView()
    private let fullViewMinHeight: CGFloat = 50
    private let fullViewTop: CGFloat = 10
    private let fullViewBottom: CGFloat = 10
    private let fullViewLeft: CGFloat = 10
    private let fullViewRight: CGFloat = 10
    private let leftView = UIView()
    
    private let centerView = UIView()
    
    private let rightView = UIView()
    private let leftViewWidth: CGFloat = 30
    private let rightViewWidth: CGFloat = 0
    
    private let label = UILabel()

    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
extension RouteHistoryTableViewCell {
    private func setupUI() {
        setupFullView()
        setupViewLayer()
        setupLeftView()
        setupRightView()
        setupCenterView()
        setupLabel()
    }
    private func setupFullView() {
        fullView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fullView)
        NSLayoutConstraint.activate([
            fullView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: fullViewTop),
            fullView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -fullViewBottom),
            fullView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: fullViewLeft),
            fullView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -fullViewRight),
            fullView.heightAnchor.constraint(greaterThanOrEqualToConstant: fullViewMinHeight),
            ])
    }
    private func setupViewLayer() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: Global_Common.shareInstance.ScreenWidth, height: 1)
        layer.backgroundColor = UIColor(r: 233, g: 233, b: 233).cgColor
        contentView.layer.addSublayer(layer)
    }
    private func setupLeftView() {
        leftView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(leftView)
        NSLayoutConstraint.activate([
            leftView.topAnchor.constraint(equalTo: fullView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            leftView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor),
            leftView.widthAnchor.constraint(equalToConstant: leftViewWidth),
            ])
    }
    private func setupRightView() {
        rightView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(rightView)
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: fullView.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor),
            rightView.widthAnchor.constraint(equalToConstant: rightViewWidth),
            ])
    }
    private func setupCenterView() {
        centerView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(centerView)
        NSLayoutConstraint.activate([
            centerView.topAnchor.constraint(equalTo: fullView.topAnchor),
            centerView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            centerView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            centerView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            ])
    }
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        centerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: centerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            ])
    }
}
extension RouteHistoryTableViewCell {
    
    func set(vm: RouteHistoryTableViewCellVM) {
        var l: String = ""
        var r: String = ""
        if vm.startType == .coordinate {
            if vm.startName == nil || vm.startName == "" { l = LocalizableStrings.savedCoordinate }
            else {
                l = vm.startName!
            }
        } else if vm.startType == .myPlace {
            l = LocalizableStrings.myPlace
        }
        if vm.stopType == .coordinate {
            if vm.stopName == nil || vm.stopName == "" { r = LocalizableStrings.savedCoordinate }
            else {
                r = vm.stopName!
            }
        } else if vm.stopType == .myPlace {
            r = LocalizableStrings.myPlace
        }
        l += " -> "
        let s = NSMutableAttributedString(string: l + r)
        s.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(r: 160, g: 160, b: 160), range: NSRange(location: 0, length: l.count))
        label.attributedText = s
    }

}


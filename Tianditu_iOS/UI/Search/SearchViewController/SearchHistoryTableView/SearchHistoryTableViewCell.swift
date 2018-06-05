//
//  SearchHistoryTableViewCell.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchHistoryTableViewCell: UITableViewCell {
    
    private let fullView = UIView()
    private let fullViewMinHeight: CGFloat = 50
    private let fullViewTop: CGFloat = 10
    private let fullViewBottom: CGFloat = 10
    private let fullViewLeft: CGFloat = 5
    private let fullViewRight: CGFloat = 10
    private let leftView = UIView()
    private let leftImageView = UIImageView()
    private let centerView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    private let rightView = UIView()
    private let leftViewWidth: CGFloat = 50
    private let rightViewWidth: CGFloat = 50
    private let centerViewLeft: CGFloat = 5
    private let centerLabel = UILabel()
    private let title = UILabel()
    private let detail = UILabel()
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
}
extension SearchHistoryTableViewCell {
    private func setupUI() {
        setupFullView()
        setupViewLayer()
        setupLeftView()
        setupRightView()
        setupCenterView()
        setupTopView()
        setupBottomView()
        setupCenterLabel()
        setupTitle()
        setupDetail()
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
        
        leftImageView.contentMode = .center
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(leftImageView)
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            leftImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            leftImageView.topAnchor.constraint(equalTo: leftView.topAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor),
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
            centerView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: centerViewLeft),
            centerView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            ])
    }
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: centerView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            ])
    }
    private func setupBottomView() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            topView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            ])
    }
    private func setupCenterLabel() {
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerView.addSubview(centerLabel)
        NSLayoutConstraint.activate([
            centerLabel.topAnchor.constraint(equalTo: centerView.topAnchor),
            centerLabel.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            centerLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            centerLabel.trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            ])
    }
    private func setupTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topView.topAnchor),
            title.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            ])
        title.font = UIFont.systemFont(ofSize: 16)
    }
    private func setupDetail() {
        detail.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(detail)
        NSLayoutConstraint.activate([
            detail.topAnchor.constraint(equalTo: bottomView.topAnchor),
            detail.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            detail.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            detail.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            ])
        detail.font = UIFont.systemFont(ofSize: 12)
        detail.textColor = UIColor(r: 120, g: 120, b: 120)
    }
    
}
extension SearchHistoryTableViewCell {
    
    func set(vm: SearchHistoryTableViewCellVM) {
        if vm.nameOnly {
            title.text = ""
            detail.text = ""
            centerLabel.text = vm.title
            leftImageView.image = Assets.search
        } else {
            title.text = vm.title
            detail.text = vm.detail
            centerLabel.text = ""
            if let i = vm.data?.type?.image {
                leftImageView.image = i
            } else {
                
            }
        }
    }
    
}

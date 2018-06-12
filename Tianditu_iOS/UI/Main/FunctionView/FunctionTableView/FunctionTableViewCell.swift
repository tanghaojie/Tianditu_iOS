//
//  FunctionTableViewCell.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class FunctionTableViewCell: UITableViewCell {
    
    private let view = UIView()
    private let viewLeftConstant: CGFloat = 60
    private let picture = UIImageView()
    private let pictureWidthAndHeight: CGFloat = 40
    private let label = UILabel()
    private let labelTrailingSpace: CGFloat = 5
    private let labelHeight: CGFloat = 21

    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
}
extension FunctionTableViewCell {
    
    private func setupUI() {
        setupContentView()
        setupView()
        setupPicture()
        setupLabel()
    }
    private func setupContentView() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
            ])
    }
    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        contentView.addConstraints([
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: viewLeftConstant),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
            ])
    }
    private func setupPicture() {
        picture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picture)
        picture.addConstraints([
            NSLayoutConstraint(item: picture, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: pictureWidthAndHeight),
            NSLayoutConstraint(item: picture, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: pictureWidthAndHeight)
            ])
        view.addConstraints([
            NSLayoutConstraint(item: picture, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: picture, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            ])
    }
    private func setupLabel() {
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(r: 151, g: 151, b: 151)
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        view.addSubview(label)
        label.addConstraint(
            NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelHeight)
        )
        view.addConstraints([
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: picture, attribute: .right, multiplier: 1, constant: labelTrailingSpace),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }
    
}
extension FunctionTableViewCell {
    
    func set(vm: FunctionTableViewCellVM) {
        picture.image = vm.image
        label.text = vm.text
    }
    
}

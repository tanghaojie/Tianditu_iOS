//
//  FunctionView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class FunctionView: UIView {
    
    let pageWidth: CGFloat = 288
    private let topViewHeight: CGFloat = 200
    private let headerImageViewWidthHeight: CGFloat = 100
    private let leftView = UIView()
    private let rightView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    private let functionTableView = FunctionTableView()
    private let headPortraitImageView = HeadPortraitImageView()
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        setupUI()
        setupGestureRecognizer()
    }
}
extension FunctionView {
    func didFinishAnimation() {
        rightView.alpha = 0.3
    }
}
extension FunctionView {
    private func setupGestureRecognizer() {
        setupRightViewTap()
    }
    private func setupRightViewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightViewTaped))
        rightView.addGestureRecognizer(tap)
    }
    @objc private func rightViewTaped() {
        removeFromSuperview()
    }
}
extension FunctionView {
    private func setupUI() {
        setupLeft()
        setupRight()
        setupTopView()
        setupBottomView()
        setupHeadPortraitImageView()
        setupFunctionTableView()
    }
    private func setupLeft() {
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.backgroundColor = .red
        addSubview(leftView)
        addConstraints([
            NSLayoutConstraint(item: leftView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)])
        leftView.addConstraint(NSLayoutConstraint(item: leftView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: pageWidth))
    }
    private func setupRight() {
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.backgroundColor = .black
        rightView.alpha = 0
        addSubview(rightView)
        addConstraints([
            NSLayoutConstraint(item: rightView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)])
    }
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .blue
        leftView.addSubview(topView)
        leftView.addConstraints([
            NSLayoutConstraint(item: topView, attribute: .top, relatedBy: .equal, toItem: leftView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topView, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topView, attribute: .right, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: 0)
            ])
        topView.addConstraint(NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: topViewHeight))
    }
    private func setupHeadPortraitImageView() {
        headPortraitImageView.translatesAutoresizingMaskIntoConstraints = false
        headPortraitImageView.isUserInteractionEnabled = true
        headPortraitImageView.layer.masksToBounds = true
        headPortraitImageView.layer.cornerRadius = headerImageViewWidthHeight / 2
        topView.addSubview(headPortraitImageView)
        headPortraitImageView.addConstraints([
            NSLayoutConstraint(item: headPortraitImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerImageViewWidthHeight),
            NSLayoutConstraint(item: headPortraitImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerImageViewWidthHeight)
            ])
        topView.addConstraints([
            NSLayoutConstraint(item: headPortraitImageView, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headPortraitImageView, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }
    private func setupBottomView() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .blue
        leftView.addSubview(bottomView)
        leftView.addConstraints([
            NSLayoutConstraint(item: bottomView, attribute: .top, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: leftView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomView, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomView, attribute: .right, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: 0)
            ])
    }
    private func setupFunctionTableView() {
        var vms = [FunctionTableViewCellVM]()
        let favor = FunctionTableViewCellVM(text: "111111") {
            [weak self] in
            let n = UINavigationController(rootViewController: FavoritesViewController())
            n.isNavigationBarHidden = true
            self?.jtGetResponder()?.present(n, animated: false, completion: nil)
            self?.rightViewTaped()
        }
        vms.append(favor)
        vms.append(FunctionTableViewCellVM(text: "2222222222"))
        vms.append(FunctionTableViewCellVM(text: "3333333333333"))

        
        functionTableView.append(vms: vms)
        
        functionTableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(functionTableView)
        bottomView.addConstraints([
            NSLayoutConstraint(item: functionTableView, attribute: .top, relatedBy: .equal, toItem: bottomView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionTableView, attribute: .bottom, relatedBy: .equal, toItem: bottomView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionTableView, attribute: .left, relatedBy: .equal, toItem: bottomView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: functionTableView, attribute: .right, relatedBy: .equal, toItem: bottomView, attribute: .right, multiplier: 1, constant: 0)
            ])
    }
}

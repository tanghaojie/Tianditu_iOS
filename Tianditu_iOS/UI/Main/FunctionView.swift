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
    private let leftView = UIView()
    private let rightView = UIView()

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
        setupTap()
    }
    
}
extension FunctionView {
    func didFinishAnimation() {
        rightView.alpha = 0.3
    }
}
extension FunctionView {
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        addGestureRecognizer(tap)
    }
    @objc private func taped() {
        removeFromSuperview()
    }
}
extension FunctionView {
    private func setupUI() {
        setupLeft()
        setupRight()
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
}

//
//  NearViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/2.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class NearViewController: JTNavigationViewController {
    
    private let scrollView = UIScrollView()
    private let scrollViewView = UIView()
    private let nearMainView = NearMainView.loadFromNib()
    
    init() {
        super.init()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nearMainView.edge()
        nearMainView.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}
extension NearViewController {
    private func setupUI() {
        setupScrollView()
        setupScrollViewView()
        setupNearMainView()
        setupTitle()
    }
    private func setupScrollView() {
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: content.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupScrollViewView() {
        scrollViewView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollViewView)
        NSLayoutConstraint.activate([
            scrollViewView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            scrollViewView.heightAnchor.constraint(equalToConstant: nearMainView.frame.height),
            ])
    }
    private func setupNearMainView() {
        nearMainView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewView.addSubview(nearMainView)
        NSLayoutConstraint.activate([
            nearMainView.topAnchor.constraint(equalTo: scrollViewView.topAnchor),
            nearMainView.bottomAnchor.constraint(equalTo: scrollViewView.bottomAnchor),
            nearMainView.leadingAnchor.constraint(equalTo: scrollViewView.leadingAnchor),
            nearMainView.trailingAnchor.constraint(equalTo: scrollViewView.trailingAnchor),
            ])
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.near
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 80),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
}

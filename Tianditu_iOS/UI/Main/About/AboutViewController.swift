//
//  AboutViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/8.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
import JTFramework

class AboutViewController: JTNavigationViewController {
    private let mainPage = UIView()
    private let aboutMainView = AboutMainView.loadFromNib()
    private var date: Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension AboutViewController {
    private func setupUI() {
        setupTitle()
        setupRightView()
        setupMainPage()
        setupAboutMainView()
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.about1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 60),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    private func setupRightView() {
        let btnAspectRatio: CGFloat = 1.5
        let width = navigationHeight * btnAspectRatio
        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.isUserInteractionEnabled = true
        navigationContent.addSubview(rightView)
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor),
            rightView.widthAnchor.constraint(equalToConstant: width),
            ])
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(rightViewLongPress))
        longPress.minimumPressDuration = 3
        rightView.addGestureRecognizer(longPress)
    }
    private func setupMainPage() {
        aboutMainView.delegate = self
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
    private func setupAboutMainView() {
        aboutMainView.translatesAutoresizingMaskIntoConstraints = false
        mainPage.addSubview(aboutMainView)
        NSLayoutConstraint.activate([
            aboutMainView.topAnchor.constraint(equalTo: mainPage.topAnchor),
            aboutMainView.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            aboutMainView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            aboutMainView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
    }
    
}
extension AboutViewController {
    @objc private func rightViewLongPress() {
        date = Date()
    }
}
extension AboutViewController: AboutMainViewDelegate {
    func appIconTaped() {
        guard let d = date else { return }
        let timeInterval = Date().timeIntervalSince(d)
        date = nil
        guard abs(timeInterval) < 10 else { return }
        let action = UIAlertAction(title: "queding", style: .default, handler: nil)
        jtAlertWithUIAlertAction(title: "212321", message: nil, uiAlertAction: [action])
    }
}

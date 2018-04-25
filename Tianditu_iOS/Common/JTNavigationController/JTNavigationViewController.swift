//
//  JTNavigationViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class JTNavigationViewController: UIViewController {

    private let fullView = UIView()
    private let navigationView = UIView()
    private let navigationViewHeight: CGFloat = 50
    private let contentView = UIView()
    private let backButton = UIButton()
    private let backButtonPadding: CGFloat = 5
    private let navigationContentView = UIView()
    weak var delegate: JTNavigationViewControllerDelegate?
    
    public var content: UIView {
        get { return contentView }
    }
    public var navigationContent: UIView {
        get { return navigationContentView }
    }
    public var navigationHeight: CGFloat {
        get { return navigationViewHeight }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = .blue
        fullView.backgroundColor = .gray
        navigationView.backgroundColor = .yellow
        contentView.backgroundColor = .white
        backButton.backgroundColor = .green
    }

}
extension JTNavigationViewController {
    private func setupUI() {
        setupFullView()
        setupNavigationView()
        setupContentView()
        setupBackButton()
        setupNavigationContentView()
    }
    private func setupFullView() {
        fullView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullView)
        if #available(iOS 11.0, *) {
            let s = self.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                fullView.leadingAnchor.constraint(equalTo: s.leadingAnchor),
                fullView.topAnchor.constraint(equalTo: s.topAnchor),
                fullView.bottomAnchor.constraint(equalTo: s.bottomAnchor),
                fullView.trailingAnchor.constraint(equalTo: s.trailingAnchor),
                ])
        } else {
            NSLayoutConstraint.activate([
                fullView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                fullView.topAnchor.constraint(equalTo: view.topAnchor),
                fullView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                fullView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                ])
        }
    }
    private func setupNavigationView() {
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(navigationView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: fullView.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: navigationViewHeight),
        ])
    }
    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
        ])
    }
    private func setupBackButton() {
        backButton.setTitle(nil, for: .normal)
        backButton.setImage(Assets.leftArrow, for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        navigationView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: backButtonPadding),
            backButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -backButtonPadding),
            backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: backButtonPadding),
            backButton.widthAnchor.constraint(equalToConstant: navigationViewHeight - backButtonPadding - backButtonPadding),
            ])
    }
    private func setupNavigationContentView() {
        navigationContentView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.addSubview(navigationContentView)
        NSLayoutConstraint.activate([
            navigationContentView.topAnchor.constraint(equalTo: navigationView.topAnchor),
            navigationContentView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor),
            navigationContentView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            navigationContentView.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor),
            ])
    }
}
extension JTNavigationViewController {
    @objc private func backButtonTouchUpInside() {
        let b = delegate?.backTouchUpInsideRecognizeJTNavigation()
        if let bb = b, !bb { return }
        if let navi = navigationController {
            if navi.viewControllers.first == self {
                navi.dismiss(animated: false, completion: nil)
            } else {
                navi.popViewController(animated: true)
            }
        } else {
            dismiss(animated: false, completion: nil)
        }
    }
}
protocol JTNavigationViewControllerDelegate: NSObjectProtocol {
    func backTouchUpInsideRecognizeJTNavigation() -> Bool
}

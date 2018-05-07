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
    private let navigationViewHeight: CGFloat
    private let contentView = UIView()
    private let backButton = UIButton()
    private let backButtonH: CGFloat = 40
    private let backButtonW: CGFloat = 24
    private let backButtonPadding: CGFloat = 5
    private let navigationContentView = UIView()
    weak var optionalDelegate: JTNavigationViewControllerOptionalDelegate?
    weak var delegate: JTNavigationViewControllerDelegate?
    
    init(_ height: CGFloat = 50) {
        var x = height
        if x < 50 { x = 50 }
        navigationViewHeight = x
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        navigationViewHeight = 50
        super.init(coder: aDecoder)
    }
    
    public var content: UIView {
        get { return contentView }
    }
    public var navigationContent: UIView {
        get { return navigationContentView }
    }
    public var navigationHeight: CGFloat {
        get { return navigationViewHeight }
    }
    public var full: UIView {
        get { return fullView }
    }
    public var backButtonWidth: CGFloat {
        get { return backButtonW }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = .white
        fullView.backgroundColor = .white
        navigationView.backgroundColor = .white
        contentView.backgroundColor = .white
        backButton.backgroundColor = .white
    }

}
extension JTNavigationViewController {
    private func setupUI() {
        setupFullView()
        setupNavigationView()
        setupViewLayer()
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
                fullView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                fullView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
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
    private func setupViewLayer() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: navigationViewHeight, width: ScreenWidth, height: 1)
        layer.backgroundColor = UIColor(r: 233, g: 233, b: 233).cgColor
        navigationView.layer.addSublayer(layer)
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
            backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: backButtonPadding),
            backButton.widthAnchor.constraint(equalToConstant: backButtonW),
            backButton.heightAnchor.constraint(equalToConstant: backButtonH),
            ])
    }
    private func setupNavigationContentView() {
        navigationContentView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.addSubview(navigationContentView)
        NSLayoutConstraint.activate([
            navigationContentView.topAnchor.constraint(equalTo: navigationView.topAnchor),
            navigationContentView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor),
            navigationContentView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: backButtonPadding),
            navigationContentView.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor),
            ])
    }
}
extension JTNavigationViewController {
    @objc private func backButtonTouchUpInside() {
        delegate?.backTouchUpInsideBegin()
        let b = optionalDelegate?.backTouchUpInsideRecognizeJTNavigation()
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
protocol JTNavigationViewControllerOptionalDelegate: NSObjectProtocol {
    func backTouchUpInsideRecognizeJTNavigation() -> Bool
}
protocol JTNavigationViewControllerDelegate: NSObjectProtocol {
    func backTouchUpInsideBegin()
}

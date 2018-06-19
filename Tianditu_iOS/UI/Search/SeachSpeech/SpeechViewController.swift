//
//  SpeechViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

@available(iOS 10.0, *)
class SpeechViewController: JTNavigationViewController {
    private let speechView = JTSpeechView.loadFromNib()
    private let mainPage = UIView()
    weak var speechDelegate: SpeechViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
@available(iOS 10.0, *)
extension SpeechViewController {
    private func setupUI() {
        setupMainPage()
        setupSpeechView()
    }
    private func setupMainPage() {
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
    private func setupSpeechView() {
        speechView.translatesAutoresizingMaskIntoConstraints = false
        speechView.delegate = self
        mainPage.addSubview(speechView)
        NSLayoutConstraint.activate([
            speechView.topAnchor.constraint(equalTo: mainPage.topAnchor),
            speechView.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            speechView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            speechView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
    }
}
protocol SpeechViewControllerDelegate: NSObjectProtocol {
    func speech(text: String)
}
@available(iOS 10.0, *)
extension SpeechViewController: JTSpeechViewDelegate {
    func speech(text: String) {
        backButtonTouchUpInside()
        speechDelegate?.speech(text: text)
    }
}

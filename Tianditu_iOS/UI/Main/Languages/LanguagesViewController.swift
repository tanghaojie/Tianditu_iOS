//
//  LanguagesViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/13.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class LanguagesViewController: JTNavigationViewController {
    private let mainPage = UIView()
    private let confirmButton = UIButton()
    private let languagesTableView = LanguagesTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension LanguagesViewController {
    private func setupUI() {
        setupTitle()
        setupConfirmButton()
        setupMainPage()
        setupLanguagesTableView()
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.language
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 63),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    private func setupConfirmButton() {
        let btnAspectRatio: CGFloat = 1.5
        let width = navigationHeight * btnAspectRatio
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.tag = 0
        confirmButton.setTitleColor(UIColor.init(r: 0, g: 122, b: 255), for: .normal)
        confirmButton.setTitle(LocalizableStrings.ok, for: .normal)
        navigationContent.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: navigationContent.topAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: navigationContent.bottomAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: navigationContent.trailingAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: width),
            ])
        confirmButton.addTarget(self, action: #selector(confirmTouchUpInside), for: .touchUpInside)
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
    private func setupLanguagesTableView() {
        languagesTableView.translatesAutoresizingMaskIntoConstraints = false
        languagesTableView.jtDelegate = self
        mainPage.addSubview(languagesTableView)
        NSLayoutConstraint.activate([
            languagesTableView.topAnchor.constraint(equalTo: mainPage.topAnchor),
            languagesTableView.bottomAnchor.constraint(equalTo: mainPage.bottomAnchor),
            languagesTableView.leadingAnchor.constraint(equalTo: mainPage.leadingAnchor),
            languagesTableView.trailingAnchor.constraint(equalTo: mainPage.trailingAnchor),
            ])
        languagesTableView.append(VMs: [LanguagesTableViewCellVM(currentLanguage: LocalizableStrings.language_zh_Hans_Current, originLanguage: LocalizableStrings.language_zh_Hans_Origin, data: JTLanguages.chinese), LanguagesTableViewCellVM(currentLanguage: LocalizableStrings.language_English_Current, originLanguage: LocalizableStrings.language_English_Origin, data: JTLanguages.english)])
        languagesTableView.reloadLanguage()
    }
}
extension LanguagesViewController {
    @objc private func confirmTouchUpInside() {
        guard let index = languagesTableView.selectedIndex else { return }
        let vm = languagesTableView.get(index: index)
        JTLanguages.set(language: vm.data)
    }
}
extension LanguagesViewController: JTLanguagesTableViewDelegate {
    func didSelectLanguage(indexPath: IndexPath, vm: LanguagesTableViewCellVM) {
        var current = JTLanguages.getCurrentUserLanguage()
        if current == nil { current = JTLanguages.getAppleLanguage() }
        if current == vm.data {
            confirmButton.isEnabled = false
            confirmButton.alpha = 0.3
        }
        else {
            confirmButton.isEnabled = true
            confirmButton.alpha = 1
        }
        languagesTableView.setTick(index: indexPath)
    }
}

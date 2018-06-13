//
//  FunctionView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework
import MBProgressHUD

class FunctionView: UIView {
    
    let pageWidth: CGFloat = 266
    private let topViewHeight: CGFloat = 200
    private let headerImageViewWidthHeight: CGFloat = 100
    private let weatherLabel2HeaderImageDistance: CGFloat = 10
    private let leftView = UIView()
    private let rightView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    private let functionTableView = FunctionTableView()
    private let headPortraitImageView = HeadPortraitImageView()
    private let weatherLabel = UILabel()
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
    func setWeather(text: String) {
        weatherLabel.text = text
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
        setupWeatherLabel()
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
        topView.backgroundColor = .white
        let subLayer = CALayer()
        subLayer.frame = CGRect(x: 0, y: topViewHeight - 2, width: pageWidth, height: 2)
        subLayer.backgroundColor = UIColor(r: 220, g: 220, b: 220).cgColor
        topView.layer.addSublayer(subLayer)
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
    private func setupWeatherLabel() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(weatherLabel)
        weatherLabel.adjustsFontSizeToFitWidth = true
        weatherLabel.textAlignment = .center
        weatherLabel.textColor = UIColor(r: 151, g: 151, b: 151)
        weatherLabel.font = UIFont.systemFont(ofSize: 12)
        topView.addConstraints([
            NSLayoutConstraint(item: weatherLabel, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherLabel, attribute: .top, relatedBy: .equal, toItem: headPortraitImageView, attribute: .bottom, multiplier: 1, constant: weatherLabel2HeaderImageDistance),
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
        let favor = FunctionTableViewCellVM(text: LocalizableStrings.favor, image: Assets.favorite) {
            [weak self] in
            let n = UINavigationController(rootViewController: FavoritesViewController())
            n.isNavigationBarHidden = true
            self?.jtGetResponder()?.present(n, animated: false, completion: nil)
            self?.rightViewTaped()
        }
        let language = FunctionTableViewCellVM(text: LocalizableStrings.language, image: Assets.language) {
            [weak self] in
            let n = UINavigationController(rootViewController: LanguagesViewController())
            n.isNavigationBarHidden = true
            self?.jtGetResponder()?.present(n, animated: false, completion: nil)
            self?.rightViewTaped()
        }
        let clearCache = FunctionTableViewCellVM(text: LocalizableStrings.clearCache, image: Assets.clearCache) {
            [weak self] in
            guard let this = self else { return }
            let view = UIView()
            guard let pView = this.jtGetResponder()?.view else { return }
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            pView.addSubview(view)
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: pView.topAnchor),
                view.bottomAnchor.constraint(equalTo: pView.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: pView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: pView.trailingAnchor),
                ])
            let hudView = UIView()
            hudView.layer.cornerRadius = 30
            hudView.clipsToBounds = true
            hudView.backgroundColor = .white
            hudView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hudView)
            NSLayoutConstraint.activate([
                hudView.widthAnchor.constraint(equalToConstant: 200),
                hudView.heightAnchor.constraint(equalToConstant: 123),
                hudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                hudView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                ])
            let jtHUD = JTHUD(view: hudView)
            let hud = jtHUD.indeterminate(removeOnHide: true, style: MBProgressHUDBackgroundStyle.blur)
            let dispatchQueue = DispatchQueue(label: "queue_clearCache")
            dispatchQueue.async {
                let cache = JTFile.shareInstance.cacheString
                let temp = JTFile.shareInstance.tmpDir
                let dirs = [cache, temp]
                let f = FileManager.default
                for dir in dirs {
                    guard let d = dir else { continue }
                    let subPaths = FileManager.default.subpaths(atPath: d)
                    guard let subs = subPaths else { return }
                    for sub in subs {
                        let full = d.appending("/\(sub)")
                        try? f.removeItem(atPath: full)
                    }
                }
                DispatchQueue.main.sync {
                    hud.mode = .text
                    hud.label.text = LocalizableStrings.cacheCleared
                }
                sleep(2)
                DispatchQueue.main.sync {
                    hud.removeFromSuperview()
                    hudView.removeFromSuperview()
                    view.removeFromSuperview()
                }
            }
            
        }
        let about = FunctionTableViewCellVM(text: LocalizableStrings.about1, image: Assets.about) {
            [weak self] in
            let n = UINavigationController(rootViewController: AboutViewController())
            n.isNavigationBarHidden = true
            self?.jtGetResponder()?.present(n, animated: false, completion: nil)
            self?.rightViewTaped()
        }
        functionTableView.append(vms: [favor, language, clearCache, about])
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

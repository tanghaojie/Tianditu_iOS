//
//  SelectLocationViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SelectLocationViewController: JTNavigationViewController {
    
    weak var selectLocationViewControllerDelegate: SelectLocationViewControllerDelegate?
    
    private let confirmButton = UIButton()
    private let confirmButtonWidth: CGFloat = 120
    private let confirmButtomHeight: CGFloat = 60
    private let confirmButtonToBottom: CGFloat = 30

    init() {
        super.init()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JTMapView.shareInstance.symbolLayerPolyline(isVisible: false)
    }
}
extension SelectLocationViewController {
    private func setupUI() {
        setupTitle()
        setupMapView()
        setupCenterPoint()
        setupConfirmButton()
    }
    private func setupTitle() {
        let label = UILabel()
        label.text = LocalizableStrings.selectLocation
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        navigationContent.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: navigationContent.centerXAnchor, constant: -(backButtonWidth / 2)),
            label.centerYAnchor.constraint(equalTo: navigationContent.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 130),
            label.heightAnchor.constraint(equalToConstant: 21),
            ])
    }
    private func setupMapView() {
        JTMapView.shareInstance.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(JTMapView.shareInstance)
        NSLayoutConstraint.activate([
            JTMapView.shareInstance.topAnchor.constraint(equalTo: content.topAnchor),
            JTMapView.shareInstance.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            JTMapView.shareInstance.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            JTMapView.shareInstance.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            ])
    }
    private func setupCenterPoint() {
        let w: CGFloat = 38
        let h: CGFloat  = 38
        let imgView = UIImageView(image: Assets.point)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.widthAnchor.constraint(equalToConstant: w),
            imgView.heightAnchor.constraint(equalToConstant: h),
            imgView.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            ])
    }
    private func setupConfirmButton() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(confirmButtonTouchUpInside), for: .touchUpInside)
        confirmButton.layer.cornerRadius = confirmButtomHeight / 5
        confirmButton.backgroundColor = UIColor(r: 0, g: 122, b: 255)
        confirmButton.setTitle(LocalizableStrings.ok, for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        content.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.widthAnchor.constraint(equalToConstant: confirmButtonWidth),
            confirmButton.heightAnchor.constraint(equalToConstant: confirmButtomHeight),
            confirmButton.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -confirmButtonToBottom)
            ])
        content.sendSubview(toBack: JTMapView.shareInstance)
        content.bringSubview(toFront: confirmButton)
        JTMapView.shareInstance.bringSubview(toFront: confirmButton)
    }
}
extension SelectLocationViewController {
    @objc func confirmButtonTouchUpInside() {
        let location = JTMapView.shareInstance.toMapPoint(JTMapView.shareInstance.center)
        if let point = location {
            navigationController?.popViewController(animated: false)
            selectLocationViewControllerDelegate?.didSelectLocation(point: point)
        }
    }
}
protocol SelectLocationViewControllerDelegate: NSObjectProtocol {
    func didSelectLocation(point: AGSPoint)
}

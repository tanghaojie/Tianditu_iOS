//
//  SelectLayerView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/24.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SelectLayerView: UIView, JTNibLoader {
    @IBOutlet weak var topTransparentView: UIView!
    @IBOutlet weak var bottomView: UIView!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupTopTransparntViewTap()
        setupTapTransparentViewSwipe()
    }
    @IBAction func normalMapTouchUpInside(_ sender: Any) {
        JTMapView.shareInstance.addDLGLayer()
        removeSelf()
    }
    @IBAction func satelliteMapTouchUpInside(_ sender: Any) {
        JTMapView.shareInstance.addDOMLayer()
        removeSelf()
    }
}
extension SelectLayerView {
    private func setupTopTransparntViewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(topTransparentViewTap))
        topTransparentView.addGestureRecognizer(tap)
    }
    private func setupTapTransparentViewSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(bottomViewSwipeDown))
        swipe.direction = .down
        bottomView.addGestureRecognizer(swipe)
    }
    @objc private func topTransparentViewTap() {
        removeSelf()
    }
    @objc private func bottomViewSwipeDown() {
        removeSelf()
    }
}
extension SelectLayerView {
    private func removeSelf() {
        removeFromSuperview()
    }
}

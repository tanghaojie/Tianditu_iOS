//
//  AboutMainView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/8.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class AboutMainView: UIView, JTNibLoader {
    weak var delegate: AboutMainViewDelegate?
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var name: UILabel!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let tap = UITapGestureRecognizer(target: self, action: #selector(appIconTaped))
        appIcon.addGestureRecognizer(tap)
        name.text = LocalizableStrings.appName
        if let i = Bundle.main.infoDictionary {
            if let v = i["CFBundleShortVersionString"] as? String {
                version.text = v
            }
        }
    }
}
extension AboutMainView {
    @objc private func appIconTaped() {
        delegate?.appIconTaped()
    }
}
protocol AboutMainViewDelegate: NSObjectProtocol {
    func appIconTaped()
}

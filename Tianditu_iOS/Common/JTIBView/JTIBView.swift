//
//  IBView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/3.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

@IBDesignable
class JTIBView: UIView {
    @IBInspectable var JTborderUIColor: UIColor = .black {
        didSet {
            layer.jtBorderUIColor = JTborderUIColor
        }
    }
    @IBInspectable var JTShadowUIColor: UIColor = .black {
        didSet {
            layer.jtShadowUIColor = JTShadowUIColor
        }
    }
}

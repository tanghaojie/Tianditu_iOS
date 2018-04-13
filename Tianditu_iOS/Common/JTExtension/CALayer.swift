//
//  CALayer.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

extension CALayer {
    var jtBorderUIColor: UIColor? {
        get {
            guard let c = borderColor else { return nil }
            return UIColor(cgColor: c)
        }
        set {
            borderColor = newValue?.cgColor
        }
    }
    var jtShadowUIColor: UIColor? {
        get {
            guard let c = shadowColor else { return nil }
            return UIColor(cgColor: c)
        }
        set {
            shadowColor = newValue?.cgColor
        }
    }
}

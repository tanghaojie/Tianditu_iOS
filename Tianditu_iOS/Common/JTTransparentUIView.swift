//
//  TransparentUIView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTTransparentUIView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let x = super.hitTest(point, with: event)
        if x == self {
            return nil
        }
        return x
    }
}

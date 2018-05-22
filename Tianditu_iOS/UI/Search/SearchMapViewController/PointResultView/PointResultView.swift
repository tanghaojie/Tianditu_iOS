//
//  SearchPointResultView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class PointResultView: UIView, JTNibLoader {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var bottom: UIView!
    @IBOutlet weak var share: UIButton!
    
    override func draw(_ rect: CGRect) {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: Global_Common.shareInstance.ScreenWidth, height: 1)
        layer.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        bottom.layer.addSublayer(layer)
        
        let l = CALayer()
        l.frame = CGRect(x: 0, y: 0, width: 1, height: share.frame.height)
        l.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        share.layer.addSublayer(l)
    }
  
    @IBAction func gotoTouchUpInside(_ sender: Any) {
        print("11111111111")
    }
    @IBAction func favoriteTouchUpInside(_ sender: Any) {
        print("favorite")
    }
    @IBAction func shareTouchUpInside(_ sender: Any) {
        print("share")
    }
    
}
extension PointResultView {
    
    func set(t: String, d: String? = nil) {
        title.text = t
        detail.text = d
    }
    
}

//
//  SearchTopLocationView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/9.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchTopLocationView: UIView, JTNibLoader {
    
    weak var delegate: SearchTopLocationViewDelegate?
    @IBOutlet weak var mapSelect: UIView!
    @IBOutlet weak var myPlace: UIView!
    @IBOutlet weak var favors: UIView!
    
    @IBAction func mapSelectTouchUpInside(_ sender: Any) {
        
    }
    @IBAction func myPlaceTouchUpInside(_ sender: Any) {
        delegate?.location(self)
    }
    @IBAction func favorsTouchUpInside(_ sender: Any) {
        
    }
    
    override func draw(_ rect: CGRect) {
        let q = CALayer()
        q.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        q.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        self.layer.addSublayer(q)
        
        let layer = CALayer()
        layer.frame = CGRect(x: mapSelect.frame.width - 1, y: 0, width: 1, height: mapSelect.frame.height)
        layer.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        mapSelect.layer.addSublayer(layer)

        let l = CALayer()
        l.frame = CGRect(x: myPlace.frame.width - 1, y: 0, width: 1, height: myPlace.frame.height)
        l.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        myPlace.layer.addSublayer(l)
    }
}
protocol SearchTopLocationViewDelegate: NSObjectProtocol {
    func location(_ atMyPlace: SearchTopLocationView)
}

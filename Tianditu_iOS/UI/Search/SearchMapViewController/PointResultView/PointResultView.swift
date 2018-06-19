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
    @IBOutlet weak var favorite: UIButton!
    private var position: Object_Attribute?
    
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
        guard let location = position, let x = location.x, let y = location.y else { return }
        let r = RoutePosition(type: .coordinate, name: location.name, x: x, y: y)
        let route = RouteViewController(stop: r)
        jtGetResponder()?.navigationController?.pushViewController(route, animated: false)
    }
    @IBAction func favoriteTouchUpInside(_ sender: Any) {
        guard let p = position else { return }
        var id: Int64 = -1
        if let iidd = p.id { id = Int64(iidd) }
        if favorite.tag == 0 {
            var d: Int16 = 0
            if let df = p.datafrom { d = Int16(df) }
            has(favorite: Data_FavoriteOperate.shareInstance.insert(address: p.address, county: p.county, datafrom: d, id: id, imageAddress: p.imageAddress, name: p.name ?? "", phone: p.phone, region: p.region, typeStr: p.typeStr, x: p.x, y: p.y))
        } else {
            has(favorite: !Data_FavoriteOperate.shareInstance.deleteByIDAndName(id: id, name: p.name ?? ""))
        }
    }
    @IBAction func shareTouchUpInside(_ sender: Any) {
        guard let p = position else { return }
        let detail = "\(p.name ?? "") \(p.region ?? "") \(p.county ?? "") \(p.address ?? "")"
        jtGetResponder()?.present(UIActivityViewController(activityItems: [detail], applicationActivities: nil), animated: true, completion: nil)
    }
}
extension PointResultView {
    func has(favorite: Bool) {
        if favorite {
            self.favorite.setImage(Assets.favorite2, for: .normal)
            self.favorite.setTitle(LocalizableStrings.hasfavorite, for: .normal)
            self.favorite.tag = 1
        } else {
            self.favorite.setImage(Assets.favorite, for: .normal)
            self.favorite.setTitle(LocalizableStrings.favorite, for: .normal)
            self.favorite.tag = 0
        }
    }
}
extension PointResultView {
    
    func set(position: Object_Attribute, t: String, d: String? = nil) {
        self.position = position
        title.text = t
        detail.text = d
        if let id = position.id { has(favorite: Data_FavoriteOperate.shareInstance.exist(id: Int64(id), name: position.name ?? "")) }
    }
    
}

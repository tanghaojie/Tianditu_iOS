//
//  SearchPointResultView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchPointResultView: UIView, JTNibLoader {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
  
    @IBAction func gotoTouchUpInside(_ sender: Any) {
        print("11111111111")
    }
}
extension SearchPointResultView {
    
    func set(t: String, d: String? = nil) {
        title.text = t
        detail.text = d
    }
    
}

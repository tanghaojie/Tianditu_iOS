//
//  SearchViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class SearchViewController: JTNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let s = JTSearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        content.addSubview(s)
    }

}

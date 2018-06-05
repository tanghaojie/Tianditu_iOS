//
//  RouteResultDetailTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/5/23.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation

class RouteResultDetailTableViewCellVM {
    let text: String
    init(text: String?) {
        if let t = text {
            self.text = t
        } else {
            self.text = " "
        }
    }
}

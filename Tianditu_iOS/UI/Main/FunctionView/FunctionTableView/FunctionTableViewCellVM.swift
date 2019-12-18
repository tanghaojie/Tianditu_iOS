//
//  FunctionTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import Foundation
import UIKit

class FunctionTableViewCellVM {
    let image: UIImage?
    let text: String
    let selectedHandler: (() -> ())?
    init(text: String, image: UIImage? = nil, selectedHandler: (() -> ())? = nil) {
        self.image = image
        self.text = text
        self.selectedHandler = selectedHandler
    }
}

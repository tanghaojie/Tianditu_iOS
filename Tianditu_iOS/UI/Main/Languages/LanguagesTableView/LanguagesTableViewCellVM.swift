//
//  LanguagesTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/13.
//  Copyright © 2018年 JT. All rights reserved.
//

import JTFramework

class LanguagesTableViewCellVM {
    let currentLanguage: String
    let originLanguage: String
    let data: JTLanguages
    
    init(currentLanguage: String, originLanguage: String, data: JTLanguages) {
        self.currentLanguage = currentLanguage
        self.originLanguage = originLanguage
        self.data = data
    }
}

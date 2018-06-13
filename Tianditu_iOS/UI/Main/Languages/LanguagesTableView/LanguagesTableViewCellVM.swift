//
//  LanguagesTableViewCellVM.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/13.
//  Copyright © 2018年 JT. All rights reserved.
//

class LanguagesTableViewCellVM {
    let currentLanguage: String
    let originLanguage: String
    
    init(currentLanguage: String, originLanguage: String) {
        self.currentLanguage = currentLanguage
        self.originLanguage = originLanguage
    }
}

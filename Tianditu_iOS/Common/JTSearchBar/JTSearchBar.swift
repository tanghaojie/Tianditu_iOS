//
//  JTSearchBar.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/17.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class JTSearchBar: UISearchBar {
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

}
extension JTSearchBar {
    private func setupUI() {
        searchBarStyle = .minimal
        placeholder = LocalizableStrings.search
        setImage(Assets.transparent, for: .search, state: .normal)
    }
}

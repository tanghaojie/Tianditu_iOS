//
//  SearchHistoryTableViewCell.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

}
extension SearchHistoryTableViewCell {
    private func setupUI() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "History"
        contentView.addSubview(label)
    }
}
extension SearchHistoryTableViewCell {
    
    func set(vm: SearchContentTableViewCellVM) {
        
    }
    
}

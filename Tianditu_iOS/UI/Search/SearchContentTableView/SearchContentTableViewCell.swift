//
//  SearchContentTableViewCell
//  Tianditu_iOS
//
//  Created by JT on 2018/4/18.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class SearchContentTableViewCell: UITableViewCell {
    
    private let fullView = UIView()
    private let fullViewMinHeight: CGFloat = 50
    private let fullViewTop: CGFloat = 10
    private let fullViewBottom: CGFloat = 10
    private let fullViewLeft: CGFloat = 10
    private let fullViewRight: CGFloat = 10
    private let leftView = UIView()
    private let topView = UIView()
    private let bottomView = UIView()
    private let rightView = UIView()
    private let leftViewWidth: CGFloat = 50
    private let rightViewWidth: CGFloat = 50

    private let title = UILabel()
    private let detail = UILabel()

    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        //leftView.backgroundColor = .red
        //topView.backgroundColor = .green
        //bottomView.backgroundColor = .yellow
        //rightView.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
}
extension SearchContentTableViewCell {
    private func setupUI() {
        setupFullView()
        setupLeftView()
        setupRightView()
        setupTopView()
        setupBottomView()
        setupTitle()
        setupDetail()
    }
    private func setupFullView() {
        fullView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(fullView)
        NSLayoutConstraint.activate([
            fullView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: fullViewTop),
            fullView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -fullViewBottom),
            fullView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: fullViewLeft),
            fullView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -fullViewRight),
            fullView.heightAnchor.constraint(greaterThanOrEqualToConstant: fullViewMinHeight),
            ])
    }
    private func setupLeftView() {
        leftView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(leftView)
        NSLayoutConstraint.activate([
            leftView.topAnchor.constraint(equalTo: fullView.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            leftView.leadingAnchor.constraint(equalTo: fullView.leadingAnchor),
            leftView.widthAnchor.constraint(equalToConstant: leftViewWidth),
            ])
    }
    private func setupRightView() {
        rightView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(rightView)
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: fullView.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: fullView.trailingAnchor),
            rightView.widthAnchor.constraint(equalToConstant: rightViewWidth),
            ])
    }
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: fullView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            topView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor),
            ])
    }
    private func setupBottomView() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(bottomView)
        NSLayoutConstraint.activate([
            topView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: fullView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            ])
    }
    private func setupTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topView.topAnchor),
            title.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            ])
        title.font = UIFont.systemFont(ofSize: 16)
    }
    private func setupDetail() {
        detail.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(detail)
        NSLayoutConstraint.activate([
            detail.topAnchor.constraint(equalTo: bottomView.topAnchor),
            detail.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            detail.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            detail.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            ])
        detail.font = UIFont.systemFont(ofSize: 12)
        detail.textColor = UIColor(r: 120, g: 120, b: 120)
    }
    
}
extension SearchContentTableViewCell {
    
    func set(vm: SearchContentTableViewCellVM) {
        title.text = vm.title
        detail.text = vm.detail
    }
    
}


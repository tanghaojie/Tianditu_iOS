//
//  SearchViewController.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class temp: JTNavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func touchUpInside() {
        let r = Request_NameSearch(name: "盛南", start: 0, end: 10)
        ServiceManager.shareInstance.provider.request(.nameSearch(data: r)) {
            result in
            switch result {
                
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                
                let data = moyaResponse.data
                let json = String(data: data, encoding: .utf8)
                guard let j = json else { return }
                let res = Response_NameSearch(JSONString: j)
                guard let rr = res else { return }
                let result = rr.success
            case let .failure(error):
                break
            }
        }
        
    }
    
}



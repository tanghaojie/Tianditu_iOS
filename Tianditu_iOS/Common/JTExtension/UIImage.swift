//
//  UIImage.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/13.
//  Copyright © 2018年 JT. All rights reserved.
//

extension UIImage {
    
    func jtData() -> (Data?, String) {
        var data: Data? = UIImageJPEGRepresentation(self, 1)
        var fileExtension = ".jpg"
        if data == nil {
            data = UIImagePNGRepresentation(self)
            fileExtension = ".png"
        }
        return (data, fileExtension)
    }
    
}

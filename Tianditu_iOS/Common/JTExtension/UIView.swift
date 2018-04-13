//
//  UIView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/13.
//  Copyright © 2018年 JT. All rights reserved.
//

import MBProgressHUD

extension UIView {
    func jtGetResponder() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    func jtMBProgressHUD_Indeterminate(removeOnHide: Bool = true, delayTimeIfAutoHide: TimeInterval? = nil) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .indeterminate
        hud.backgroundView.style = .blur
        hud.removeFromSuperViewOnHide = true
        if let hd = delayTimeIfAutoHide {
            hud.hide(animated: true, afterDelay: hd)
        }
        return hud
    }
    
}

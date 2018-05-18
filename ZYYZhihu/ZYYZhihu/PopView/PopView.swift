//
//  PopView.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

// MARK:- LoadingView
struct LoadingView {
    static func show(in parentView: UIView, text: String? = nil) {
        
    }
}

// MARK:- ToastView
struct ToastView {
    static let animationDuration: TimeInterval = 3
    
    static func show(in parentView: UIView, text: String) {
        let hud = MBProgressHUD(view: parentView)
        hud.detailsLabel.text = text;
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 13);
        hud.mode = .text
        hud.offset.y = 0;
        hud.removeFromSuperViewOnHide = true;
        hud.clickOutSideToHide = true;
//        hud.tag = 99999;
        parentView.addSubview(hud)
        
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: animationDuration)
    }
    
    static func hide(in parentView: UIView) {
        MBProgressHUD.hide(for: parentView, animated: false)
    }
}


private var clickOutSideToHideKey: Void?

extension MBProgressHUD {
    var clickOutSideToHide: Bool? {
        get {
            return objc_getAssociatedObject(self, &clickOutSideToHideKey) as? Bool
        }
        
        set {
            objc_setAssociatedObject(self, &clickOutSideToHideKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let clickOutSideToHide = clickOutSideToHide else {
            return super.touchesBegan(touches, with: event)
        }
        
        guard clickOutSideToHide else {
            return super.touchesBegan(touches, with: event)
        }
        
        let touch = touches.first
        
        if let touchView = touch?.view, touchView.isDescendant(of: self) {
            self.hide(animated: true)
        }
    }
}

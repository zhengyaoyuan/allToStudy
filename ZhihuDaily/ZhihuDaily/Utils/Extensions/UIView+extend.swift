//
//  UIView+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK:- Frame
    var width: CGFloat {
        get {
            return frame.size.width
        }
        
        set(width) {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set(height) {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        
        set(left) {
            var frame = self.frame
            frame.origin.x = left
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        
        set(right) {
            var frame = self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
    }
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        
        set(top) {
            var frame = self.frame
            frame.origin.y = top
            self.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        
        set(bottom) {
            var frame = self.frame
            frame.origin.y = bottom - self.frame.size.height
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        
        set(centerX) {
            center = CGPoint.init(x: centerX, y: center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        
        set(centerY) {
            center = CGPoint.init(x: center.x, y: centerY)
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        
        set(size) {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        
        set(origin) {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    // MARK:- Layer  cornerRadius border
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set(cornerRadius) {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }

        set(borderColor) {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set(borderWidth) {
            layer.borderWidth = borderWidth
        }
    }
}

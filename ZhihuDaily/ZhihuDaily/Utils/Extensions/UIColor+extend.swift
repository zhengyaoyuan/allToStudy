//
//  UIColor+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

extension UIColor {
    // hex:十六进制
    static func RGBHex(_ hex: Int) -> UIColor {
        return RGBHexA(hex, 255)
    }
    
    // hex:十六进制 a:透明度
    static func RGBHexA(_ hex: Int, _ a: CGFloat) -> UIColor {
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = hex & 0xFF
        return RGBA(r, g, b, a)
    }
    
    static func RGB(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return RGBA(r, g, b, 1.0)
    }
    
    static func RGBA(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    // 获取随机颜色
    static func getRandomColor(withAlpha alpha: CGFloat) -> UIColor {
        
        let r = arc4random() % 100
        let g = arc4random() % 100
        let b = arc4random() % 100
        
        let color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        
        return color
    }
}


//
//  UIScreen+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

extension UIScreen {
    static let normalSize: CGSize = {
        let size = UIScreen.main.bounds.size
        let w = size.width
        let h = size.height
        if w > h {
            return CGSize(width: h, height: w)
        } else {
            return size
        }
    }()
    
    static var width: CGFloat {
        return self.normalSize.width
    }
    
    static var height: CGFloat {
        return self.normalSize.height
    }
    
}

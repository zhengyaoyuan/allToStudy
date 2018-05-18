//
//  UIWindow+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

extension UIWindow {
    static var appWindow: UIWindow {
        return UIApplication.shared.windows[0]
    }
}

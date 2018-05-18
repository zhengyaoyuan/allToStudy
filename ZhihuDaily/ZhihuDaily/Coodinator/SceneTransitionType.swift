//
//  SceneTransitionType.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    case root(UIViewController)
    case push(UIViewController)
    case present(UIViewController)
    case alert(UIViewController)
}

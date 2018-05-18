//
//  Router.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

typealias Completion = () -> Void

enum PageMap {
    case DemoPage1
    case DemoPage2(String)
    
    var vc: UIViewController {
        switch self {
        case .DemoPage1:
            return DemoViewController1()
        case .DemoPage2(let title):
            return DemoViewController2(customTitle: title)
        }
    }
}

enum Router {
    case Push(PageMap)
    case Present(PageMap)
    
    func go(from vc: UIViewController,
            animated: Bool = true, completion: Completion? = nil) {
        switch self {
        case .Push(let map):
            vc.navigationController?.pushViewController(map.vc, animated: animated)
        case .Present(let map):
            vc.present(map.vc, animated: true, completion: completion)
        }
    }
}

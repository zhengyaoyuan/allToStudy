//
//  Scene.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case home(HomeViewModel)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        // 这里的 case let 的作用是？
        case let .home(viewModel):
            var vc = HomeViewController.instantiateFromNib()
            let rootViewController = UINavigationController(rootViewController: vc)
            vc.bind(to: viewModel)

            rootViewController.navigationBar.barTintColor = R.color.main()
            UIApplication.shared.statusBarStyle = .lightContent

            return .root(rootViewController)
        }
    }

}

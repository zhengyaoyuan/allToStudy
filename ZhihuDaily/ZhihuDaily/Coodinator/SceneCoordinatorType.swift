//
//  SceneCoordinatorType.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/22.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    init(window: UIWindow)

    @discardableResult func transition(to scene: TargetScene) -> Observable<Void>
    @discardableResult func pop(animated: Bool) -> Observable<Void>
}

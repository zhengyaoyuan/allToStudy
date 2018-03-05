//
//  Protocol.swift
//  LoginWithRxSwift
//
//  Created by 郑尧元 on 2018/3/2.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

// 表示我们的一些请求的结果
enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}

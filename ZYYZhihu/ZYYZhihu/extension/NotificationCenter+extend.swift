//
//  NotificationCenter+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift

// case 有可能会暴涨，要分模块 enum，需要进一步修改
enum ZYYNotification: String {
    case userLogout
    case userLogin
    
    var stringValue: String {
        return "ZYY" + rawValue
    }
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(stringValue)
    }
}


/*
 示例写法
 
 // 监听通知
 let _ = NotificationCenter.default.rx
 .notification(custom: .userLogin)
 .subscribe(onNext: { notification in
 print("用户登录成功啦")
 })
 .disposed(by: disposeBag)
 
 // 发送通知
 NotificationCenter.post(customeNotification: .userLogin)
 */
extension NotificationCenter {
    static func post(customeNotification name: ZYYNotification, object: AnyObject? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name.notificationName, object: object, userInfo: userInfo)
    }
}

extension Reactive where Base: NotificationCenter {
    func notification(custom name: ZYYNotification, object: AnyObject? = nil) -> Observable<Notification> {
        return notification(name.notificationName, object: object)
    }
}



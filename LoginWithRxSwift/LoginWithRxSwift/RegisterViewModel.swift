//
//  RegisterViewModel.swift
//  LoginWithRxSwift
//
//  Created by 郑尧元 on 2018/3/2.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    //input:
    let username = Variable<String>("") //初始值为""
    
    // output:
    let usernameUsable: Observable<Result>
    
    init() {
        let service = ValidationService.instance
        
        usernameUsable = username.asObservable()
            .flatMapLatest{ username in
                return service.validateUsername(username)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(message: "username检测出错"))
            }
            .share(replay: 1)
    }
}



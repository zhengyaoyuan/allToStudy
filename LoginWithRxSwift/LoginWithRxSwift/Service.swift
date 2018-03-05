//
//  Service.swift
//  LoginWithRxSwift
//
//  Created by 郑尧元 on 2018/3/2.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation
import RxSwift
//import RxCocoa

class ValidationService {
    static let instance = ValidationService()
    
    private init() {}
    
    let minCharactersCount = 6
    
    func validateUsername(_ username: String) -> Observable<Result> {
        if username.count == 0 {
            return .just(.empty)
        }
        
        if username.count < minCharactersCount {
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
        if usernameValid(username) {
            return .just(.failed(message: "账户已存在"))
        }
        
        return .just(.ok(message: "用户名可用"))
    }
    
    
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        let usernameArray = userDic?.allKeys
        guard usernameArray != nil else {
            return false
        }
        
        if (usernameArray! as NSArray).contains(username ) {
            return true
        } else {
            return false
        }
    }
}

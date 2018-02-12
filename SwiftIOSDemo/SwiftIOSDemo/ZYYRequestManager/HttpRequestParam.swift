//
//  HTTPRequestParam.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit

class HTTPRequestParam: NSObject, Codable {
    let platform = 3
    var FuncTag: String
    var userId: Int
    
    init(FuncTag: String, userId: Int = 0) {
        self.FuncTag = FuncTag
        self.userId = userId
    }
    
//    func modelToDic() -> [String: Any] {
//        
//    }
}

class HTTPRequestHomeBannerListParam: HTTPRequestParam {
    let moduleId: Int
    
    init(userId: Int) {
        self.moduleId = 1
        super.init(FuncTag: "80010012", userId: userId)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}

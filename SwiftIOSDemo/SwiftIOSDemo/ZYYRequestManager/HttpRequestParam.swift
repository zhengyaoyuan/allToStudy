//
//  HTTPRequestParam.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/2/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import UIKit
import ObjectMapper

// SV 专用
protocol HttpRequestEncodedParam {
    func getParam() -> String
}

// 只有 class 才能继承！

class HTTPRequestParam: Codable {
    let platform = 3
    let a = 0
    let c: Int
    let FuncTag: String
    
    var userId: Int?
    var token: String?
    
    
    init(FuncTag: String) {
        c = Bundle.main.infoDictionary!["StoreID"]! as! Int
        self.FuncTag = FuncTag
    }
}


class HTTPRequestHomeBannerListParam: HTTPRequestParam {
    let moduleId: Int
    
    init(moduleId: Int, userId: Int) {
        self.moduleId = moduleId
        
        super.init(FuncTag: "80010012")
        self.userId = userId
    }
    
    // 派生必须写的方法
    enum Key: String, CodingKey {
        case moduleId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.moduleId = try container.decode(Int.self, forKey: .moduleId)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(moduleId, forKey: Key.moduleId)
        
        try super.encode(to: encoder)
    }
}

//["FuncTag": "80010004", "isTop": isTop]

class HTTPRequestActivityListParam: HTTPRequestParam {
    let isTop: Int
    
    init(isTop: Int) {
        self.isTop = isTop
        super.init(FuncTag: "80010004")
    }
    
    enum Key: String, CodingKey {
        case isTop
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.isTop = try container.decode(Int.self, forKey: .isTop)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(isTop, forKey: Key.isTop)
        
        try super.encode(to: encoder)
    }
}


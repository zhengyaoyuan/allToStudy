//
//  UserDefaults+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

// FIXME:- 都没写好

/*
 原本的写法 key 需要用字符串
 UserDefaults.standard.set("zyy", forKey: "username")
 范例：避免使用 String
 UserDefaults.TestData.username.store(value: "zyy")


 */

// FIXME:- 还需要加一个枚举的关联值，规定某枚举下只能
extension UserDefaults {
    enum TestData: String, UserDefaultSettable {
        case username
    }
}

public protocol UserDefaultSettable {
    var uniqueKey: String { get }
}

public extension UserDefaultSettable
    where Self: RawRepresentable, Self.RawValue == String {

    // removed object from standard userdefaults
    public func removed() {
        UserDefaults.standard.removeObject(forKey: uniqueKey)
    }
    
    // MARK:- Any
    public func store(value: Any?){
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedValue: Any? {
        return UserDefaults.standard.value(forKey: uniqueKey)
    }
    
    // MARK:- String
    public var storedString: String? {
        return storedValue as? String
    }
    
    // MARK:- URL
    public func store(url: URL?) {
        UserDefaults.standard.set(url, forKey: uniqueKey)
    }
    public var storedURL: URL? {
        return UserDefaults.standard.url(forKey: uniqueKey)
    }
    // MARK:- Bool
    public func store(value: Bool) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedBool: Bool {
        return UserDefaults.standard.bool(forKey: uniqueKey)
    }
    // MARK:- Int
    public func store(value: Int) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedInt: Int {
        return UserDefaults.standard.integer(forKey: uniqueKey)
    }
    // MARK:- Double
    public func store(value: Double) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedDouble: Double {
        return UserDefaults.standard.double(forKey: uniqueKey)
    }
    // MARK:- Float
    public func store(value: Float) {
        UserDefaults.standard.set(value, forKey: uniqueKey)
    }
    public var storedFloat: Float {
        return UserDefaults.standard.float(forKey: uniqueKey)
    }
    
    // MARK:- uniqueKey Self.self 是？
    public var uniqueKey: String {
        return "\(Self.self).\(rawValue)"
    }
}


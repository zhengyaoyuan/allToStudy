//
//  ZYYProtocol.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/3/8.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

protocol protocolA {
    
    func needToImple()
    
    func needD()
    
    var mustBeSetable: Int { get set }
    
}

extension protocolA {
    func needToImple() {
        print("协议的扩展中实现一些函数")
    }
    
    func needA() {
        
    }
}

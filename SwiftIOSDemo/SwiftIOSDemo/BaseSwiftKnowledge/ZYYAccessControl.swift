//
//  ZYYAccessControl.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/3/8.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

// private 只有在其定义的作用域或者在同一个文件内的 extension 里可供访问
// fileprivate 只能在其定义的文件内部使用
// internal 默认权限 ，同一模块下都可以访问到
// public 其它模块也能访问到
// open  不仅能访问，还能够重写

// 原则

class A {
    private let str = ""
    private func privateA() {
        
    }
    
    fileprivate func fileprivateB() {
        privateA()
    }
}

extension A {
    func extensionA() {
        
        privateA()
    }
}

fileprivate extension A {
    func extensionB() {
        
        privateA()
    }
}


class B {
    
    public let a = A()
    
    func normalB() {
        
//        a.str
        
        // error
//        a.privateA()
        
        
        a.fileprivateB()
        
    }
}


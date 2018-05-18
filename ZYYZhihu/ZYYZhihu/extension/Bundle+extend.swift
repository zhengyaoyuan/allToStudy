//
//  Bundle+extend.swift
//  ZYYZhihu
//
//  Created by 郑尧元 on 2018/4/14.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

extension Bundle {
    static func LV0(_ name: String) -> Any? {
        let nullableArray = main.loadNibNamed(name, owner: self, options: nil)
        if let array = nullableArray, array.count > 0 {
            return array[0]
        } else {
            return nil
        }
    }
    
    static func LV(_ name: String, _ index: Int) -> Any? {
        let nullableArray = main.loadNibNamed(name, owner: self, options: nil)
        if let array = nullableArray, array.count > index {
            return array[index]
        } else {
            return nil
        }
    }
}

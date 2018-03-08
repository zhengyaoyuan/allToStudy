//
//  ZYYInitialization.swift
//  SwiftIOSDemo
//
//  Created by 郑尧元 on 2018/3/8.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

import Foundation

class Food {
    var name: String
    
    // desinated usally provide 1
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
        
        self.quantity = 230
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
        
        self.quantity = 23
    }
    
}

class TestInitialization {
    
    func create() {

        var age: Int?
        
        
        age = 17
        age = nil
        
        switch age {
        case .none:
            print("No value")
        case .some(let value):
            print("Got a value:\(age)")
        }
        
    }
}


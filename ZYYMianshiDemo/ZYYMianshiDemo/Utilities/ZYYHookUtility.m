//
//  ZYYHookUtility.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ZYYHookUtility.h"

#import <objc/runtime.h>

@implementation ZYYHookUtility

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    // YES 说明 方法混淆的类的父类已经实现了那个 混淆方法的实现。（如果父类和子类都实现了混淆方法，最终调用的还是子类方法）
    // NO 是代表其它所有情况
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        // 之前子类的老 selector 已经对上 新实现。
        // 现在要做的是给新selector 加上 老实现
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


@end

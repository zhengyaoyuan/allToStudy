//
//  ZYYHookUtility.h
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYYHookUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

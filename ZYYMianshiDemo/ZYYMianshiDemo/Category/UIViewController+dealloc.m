//
//  UIViewController+dealloc.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "UIViewController+dealloc.h"

@implementation UIViewController (dealloc)

- (void)dealloc
{
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

@end

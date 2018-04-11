//
//  MyClass+Category1.m
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/10.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "MyClass+Category1.h"

@implementation MyClass (Category1)

+ (void)load {
    NSLog(@"%@",@"Category1");
}

- (void)printName
{
    NSLog(@"printName %@",@"Category1");
}

@end

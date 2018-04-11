//
//  MyClass+Category2.m
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/10.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "MyClass+Category2.h"

@implementation MyClass (Category2)

+ (void)load {
    NSLog(@"%@",@"Category2");
}

- (void)printName
{
    NSLog(@"printName %@",@"Category2");
}

@end

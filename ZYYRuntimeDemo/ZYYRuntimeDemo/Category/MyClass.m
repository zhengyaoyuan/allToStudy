//
//  MyClass.m
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/10.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass

+ (void)load {
    NSLog(@"%@",@"MyClass");
}

- (void)printName
{
    NSLog(@"printName %@",@"MyClass");
}

@end

@implementation MyClass(MyAddition1)

- (void)printName
{
    NSLog(@"%@",@"MyAddition");
}

@end


@implementation MyClass(MyAddition)

- (void)printName
{
    NSLog(@"%@",@"MyAddition");
}

@end



//
//  MyClass.h
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/10.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject
- (void)printName;
@end

@interface MyClass(MyAddition)

@property(nonatomic, copy) NSString *name;

- (void)printName;

@end

@interface MyClass(MyAddition1)

@property(nonatomic, copy) NSString *name;

- (void)printName;

@end

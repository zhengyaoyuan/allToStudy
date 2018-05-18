//
//  MyClass.m
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/10.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "MyClass.h"
#import <objc/runtime.h>

void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@" >> dynamicMethodIMP");
}

@interface MyClassAddMiss : NSObject

@end

@implementation MyClassAddMiss

- (void)missMethod1 {
    NSLog(@"missMethod1");
}

- (void)missMethod2 {
    NSLog(@"missMethod2");
}

@end


@implementation MyClass

+ (void)load {
    NSLog(@"%@",@"MyClass");
}

- (void)printName
{
    NSLog(@"printName %@",@"MyClass");
}

// 动态给 sel 增加 imp，可以叫做动态决议
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(missMethod)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 选择备援对象
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(missMethod1)) {
        MyClassAddMiss *a = [[MyClassAddMiss alloc] init];
        
        return a;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - forwardInvocation
// 转发逻辑
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    MyClassAddMiss *a = [[MyClassAddMiss alloc] init];
    if ([a respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:a];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

// 利用有 selector 的对象，获取其签名，返回，用于生成 NSInvocation。
// 这个方法不重写， forwardInvocation 不会调用
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig;
    MyClassAddMiss *a = [[MyClassAddMiss alloc] init];
    sig = [a methodSignatureForSelector:aSelector];
    if (sig) return sig;
    return nil;
//    return [super methodSignatureForSelector:aSelector];
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



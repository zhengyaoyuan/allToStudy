//
//  NSTimer+blockSupport.m
//  ZYYRetainCycleDemo
//
//  Created by 郑尧元 on 2018/3/25.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "NSTimer+blockSupport.h"

@implementation NSTimer (blockSupport)

+ (NSTimer *)zyy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats {
    // note：这里的 target 是一个类对象 单例，查找其 selector 是从 其元类里查找 + 的类方法的！！
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(zyy_blockInvoke:) userInfo:block repeats:repeats];
}

+ (void)zyy_blockInvoke:(NSTimer *)timer {
    void (^block) (void) = timer.userInfo;
    
    if (block) {
        block();
    }
}

@end

//
//  NSTimer+blockSupport.h
//  ZYYRetainCycleDemo
//
//  Created by 郑尧元 on 2018/3/25.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (blockSupport)

+ (NSTimer *)zyy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)(void))block
                                        repeats:(BOOL)repeats;

@end

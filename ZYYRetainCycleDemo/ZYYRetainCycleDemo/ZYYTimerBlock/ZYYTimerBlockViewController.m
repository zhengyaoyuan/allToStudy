//
//  ZYYTimerBlockViewController.m
//  ZYYRetainCycleDemo
//
//  Created by 郑尧元 on 2018/3/25.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYTimerBlockViewController.h"
#import "NSTimer+blockSupport.h"

@interface ZYYTimerBlockViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZYYTimerBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self startTimer];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer zyy_scheduledTimerWithTimeInterval:2 block:^{
        // 1. 有循环引用
//        [self emitToConsole];
        
        // 2. 没有循环引用
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf emitToConsole];
        }
    
    } repeats:YES];
}

- (void)emitToConsole {
    NSLog(@"定时器触发");
}

@end

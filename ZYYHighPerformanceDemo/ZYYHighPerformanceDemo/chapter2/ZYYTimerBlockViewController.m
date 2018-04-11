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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerSth) name:@"nono" object:nil];
    
    
}

- (void)observerSth {
    
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    
    // 引用关系为：vc 持有 timer，timer 持有 NSTimer 类对象，打破了循环引用，
    // 只有 容器 vc 持有当前 vc。当 vc 退出销毁时，timer 对象也会 dealloc
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

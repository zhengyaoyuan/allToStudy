//
//  ZYYCalculateInBgVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/25.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ZYYCalculateInBgVC.h"

@interface ZYYCalculateInBgVC ()

@property (weak, nonatomic) IBOutlet UIView *blackView;

@end

@implementation ZYYCalculateInBgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"复杂计算在后台线程";
    
    UIView *view = [UIView new];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    view.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
    
    view.autoresizingMask &= ~UIViewAutoresizingFlexibleHeight;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self complicatedCalculate];
    });
    
//    [self complicatedCalculate];
}

- (void)complicatedCalculate
{
    for (int i = 0; i < 100000; i++) {
        NSInteger total = 0;
        for (int j = 0; j < 10000; j++) {
            total += j;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self animated];
    });
}

- (void)animated
{
    // 动画
    [UIView animateWithDuration:5 animations:^{
        CGRect frame = self.blackView.frame;
        frame.origin.x += 200.f;
        self.blackView.frame = frame;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

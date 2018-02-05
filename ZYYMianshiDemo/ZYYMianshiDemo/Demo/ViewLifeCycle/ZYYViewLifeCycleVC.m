//
//  ZYYViewLifeCycleVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/2/5.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYViewLifeCycleVC.h"
#import "ZYYLifeCycleView.h"

@interface ZYYViewLifeCycleVC ()

@end

@implementation ZYYViewLifeCycleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
}

- (void)commonInit {
    ZYYLifeCycleView *lifeCycleView = [[ZYYLifeCycleView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    [self.view addSubview:lifeCycleView];
    
    CGSize size = [lifeCycleView sizeThatFits:CGSizeMake(10.f, 10.f)];
    
    NSLog(@"我的");
}

@end

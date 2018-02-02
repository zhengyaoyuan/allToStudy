//
//  ZYYSwizzlingBaseVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/1/3.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYSwizzlingBaseVC.h"

@interface ZYYSwizzlingBaseVC ()

@end

@implementation ZYYSwizzlingBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)swiz_viewDidAppear:(BOOL)animated
{
    NSLog(@"父类的方法混淆");
    [self swiz_viewDidAppear:animated];
}

@end

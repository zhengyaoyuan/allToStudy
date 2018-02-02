//
//  ZYYDebugVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/1/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYDebugVC.h"
#import "ZYYDog.h"
#import <objc/runtime.h>

@interface ZYYDebugVC ()

@end

@implementation ZYYDebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYYDog *dog = [[ZYYDog alloc] init];
    // Do any additional setup after loading the view.
    dog.dogAge = 3;
    dog.dogName = @"hxm";
    
//    unsigned int count = 0;

//    Ivar *ivars = class_copyIvarList([dog class], &count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

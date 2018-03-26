//
//  ViewController.m
//  ZYYCDemo
//
//  Created by 郑尧元 on 2018/3/26.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = 10;
    
    // 1.常指针，指向一个常量的指针
    int const *p = &a;
    int b = 12;
    // 可以修改指向的地址
    p = &b;
    // error，不能变量值
//    *p = 30;
    
    // 2.指针常量，指针所保存的地址不可修改，但能修改变量
    int * const q = &a;
    // 修改指针保存的地址 error
//    q = &b;
    // 修改变量值可以操作
    *q = 4;
    
    // 3. 常指针常量
    int const * const cc = &a;
    // 以下均报错
//    cc = &b;
//    *cc = 18;
}

@end

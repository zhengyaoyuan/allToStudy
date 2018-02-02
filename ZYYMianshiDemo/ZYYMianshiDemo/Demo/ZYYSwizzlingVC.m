//
//  ZYYSwizzlingVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/1/3.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYSwizzlingVC.h"
#import "ZYYHookUtility.h"

@interface ZYYSwizzlingVC ()

@end

@implementation ZYYSwizzlingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzleSelector = @selector(swiz_viewDidAppear:);
        
        [ZYYHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzleSelector];
    });
}

- (void)swiz_viewDidAppear:(BOOL)animated
{
    NSLog(@"子类的方法混淆");
    [self swiz_viewDidAppear:animated];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    NSLog(@"原来的方法实现");
//}

@end

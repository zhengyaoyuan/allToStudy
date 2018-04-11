//
//  ViewController.m
//  ZYYMRCDemo
//
//  Created by 郑尧元 on 2018/3/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"dd"];
    NSLog(@"%@", @(array.count));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

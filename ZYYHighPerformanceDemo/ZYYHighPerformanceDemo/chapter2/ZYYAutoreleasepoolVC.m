//
//  ZYYAutoreleasepoolVC.m
//  ZYYHighPerformanceDemo
//
//  Created by 郑尧元 on 2018/3/27.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYAutoreleasepoolVC.h"

static const NSInteger loop = 1000000;

@interface ZYYAutoreleasepoolVC ()

@end

@implementation ZYYAutoreleasepoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onBtnNotUsePool:(id)sender {
    for (NSUInteger i = 0; i < loop; i++) {
        NSObject *obj = [NSObject new];
//        NSLog(@"%@", obj);
    }
}

- (IBAction)onBtnUsePool:(id)sender {
    for (NSUInteger i = 0; i < loop; i++) {
        @autoreleasepool {
            NSObject *obj = [NSObject new];
//            NSLog(@"%@", obj);
        }
    }
}

@end

//
//  ViewController.m
//  ZYYHighPerformanceDemo
//
//  Created by 郑尧元 on 2018/3/21.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"
#import "ZYYPhoto.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createUnsafeUnretainedPhoto];
    
}

- (void)createUnsafeUnretainedPhoto {
    ZYYPhoto * __unsafe_unretained photo = [[ZYYPhoto alloc] init];
    
    photo.title = @"unsafe";
    
    NSLog(@"%@", photo.title);
    
}


@end

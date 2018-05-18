//
//  ViewController.m
//  ZYYAutoLayoutDemo
//
//  Created by 郑尧元 on 2018/4/26.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZYYLabel.h"

@interface ViewController ()

@property (nonatomic, strong) ZYYLabel *testLabel1;

@property (nonatomic, strong) UILabel *testLabel2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

//    [self createIntrinsicContentLabel];
    [self createMultipleLineLabel];
}

- (void)createIntrinsicContentLabel {
    _testLabel1 = [[ZYYLabel alloc] init];
    _testLabel1.textAlignment = NSTextAlignmentCenter;
    _testLabel1.font = [UIFont systemFontOfSize:14.0];
    _testLabel1.textColor       = [UIColor whiteColor];
    _testLabel1.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:_testLabel1];

    [_testLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.left.equalTo(self.view.mas_left).offset(10);
    }];
    _testLabel1.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张";
}

- (void)createMultipleLineLabel {
    _testLabel2 = [[ZYYLabel alloc] init];
    _testLabel2.textAlignment = NSTextAlignmentCenter;
    _testLabel2.font = [UIFont systemFontOfSize:14.0];
    _testLabel2.textColor       = [UIColor whiteColor];
    _testLabel2.backgroundColor = [UIColor lightGrayColor];

    // 多行显示，最关键的两行代码
    _testLabel2.preferredMaxLayoutWidth = 100.f;
    _testLabel2.numberOfLines = 0;

    [self.view addSubview:_testLabel2];

    [_testLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(40);
        make.left.equalTo(self.view.mas_left).offset(10);
    }];
    _testLabel2.text = @"天地玄黄 宇宙洪荒 日月盈昃 辰宿列张";

    CGSize size = [_testLabel2 sizeThatFits:CGSizeMake(100.f, CGFLOAT_MAX)];
    NSLog(@"%@", NSStringFromCGSize(size));
}

@end

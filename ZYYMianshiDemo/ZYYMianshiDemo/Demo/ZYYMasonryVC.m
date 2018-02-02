//
//  ZYYMasonryVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ZYYMasonryVC.h"
#import "Masonry.h"
#import "ZYYMasonryVC+Private.h"

@interface ZYYMasonryVC ()

@end

@implementation ZYYMasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *view = [UIView new];
    [self.view addSubview:view];
    
    
    self.redView.backgroundColor = [UIColor grayColor];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view).inset(30.f);
        make.size.mas_equalTo(CGSizeMake(10.f, 10.f));
    }];
}

- (void)p_privateMethod
{
    
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

//
//  ZYYLifeCycleView.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/2/5.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYLifeCycleView.h"


/**
 1. drawRect
 2. layoutSubviews
 
 */
@implementation ZYYLifeCycleView

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize returnSize = [super sizeThatFits:size];
    NSLog(@"sizeThatFits called");
    return returnSize;
}


@end

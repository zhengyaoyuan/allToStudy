//
//  ZYYLabel.m
//  ZYYAutoLayoutDemo
//
//  Created by 郑尧元 on 2018/4/26.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYLabel.h"

@implementation ZYYLabel

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];

//    size.width += 20.f;
//    size.height += 20.f;

    return size;
}

@end

//
//  ScenicCellViewModel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POICellViewModel.h"

@class Scenic;

/**
 子类 ViewModel，套用业务逻辑
 */
@interface ScenicCellViewModel : POICellViewModel

@property (nonatomic) NSInteger currentCityID;

- (instancetype)initWithScenic:(Scenic *)scenic;

@end

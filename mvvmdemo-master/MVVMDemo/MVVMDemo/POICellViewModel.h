//
//  POICellViewModel.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCellViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 父类 ViewModel 包含 UI 属性，用于与 View 绑定
 主要是声明一些信号 这一层只有 UI！！
 */
@interface POICellViewModel : BaseCellViewModel

@property (nonatomic) RACSignal *frontImageSignal; //UIImage
@property (nonatomic) RACSignal *titleSignal; //NSString
@property (nonatomic) RACSignal *priceSignal; //NSAttributeText
@property (nonatomic) RACSignal *campaignSignal; //NSString
@property (nonatomic) RACSignal *campaignHiddenSignal; //NSNumber(BOOL)
@property (nonatomic) RACSignal *rightFooterSignal; //NSString

@end

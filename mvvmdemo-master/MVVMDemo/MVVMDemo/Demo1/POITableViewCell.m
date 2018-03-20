//
//  ScenicCell.m
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import "POITableViewCell.h"
#import "POICellViewModel.h"

@interface POITableViewCell ()

@property (nonatomic) POICellViewModel *viewModel;

@end

@implementation POITableViewCell


/**
 用于 viewModel 和 View 进行绑定
 */
- (void)bindWithViewModel:(POICellViewModel *)viewModel
{
    // 每次 cell 重用了，开始重新绑定
    RAC(_titleLabel, text) = [viewModel.titleSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_priceLabel, attributedText) = [viewModel.priceSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_rightFooterLabel, text) = [viewModel.rightFooterSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignLabel, text) = [viewModel.campaignSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_campaignView, hidden) = [viewModel.campaignHiddenSignal takeUntil:self.rac_prepareForReuseSignal];
    RAC(_frontImageView, image) = [viewModel.frontImageSignal takeUntil:self.rac_prepareForReuseSignal];
    _viewModel = viewModel;
}

@end

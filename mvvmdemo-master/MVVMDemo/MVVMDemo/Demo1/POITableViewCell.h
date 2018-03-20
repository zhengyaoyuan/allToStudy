//
//  ScenicCell.h
//  MVVMDemo
//
//  Created by Liang Shixing on 16/7/25.
//  Copyright © 2016年 Liang Shixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

/**
 Cell 将所有控件暴露在 .h 文件里
 */
@interface POITableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightFooterLabel;
@property (weak, nonatomic) IBOutlet UILabel *campaignLabel;
@property (weak, nonatomic) IBOutlet UIView *campaignView;

@end

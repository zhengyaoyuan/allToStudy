//
//  ZYYMianshiCell.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/25.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ZYYMianshiCell.h"

@interface ZYYMianshiCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZYYMianshiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end

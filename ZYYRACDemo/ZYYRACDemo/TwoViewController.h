//
//  TwoViewController.h
//  ZYYRACDemo
//
//  Created by 郑尧元 on 2018/3/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <ReactiveObjC/ReactiveObjC.h>

@class RACSubject;

@interface TwoViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end

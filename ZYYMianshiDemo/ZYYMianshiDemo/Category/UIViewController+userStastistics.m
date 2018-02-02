//
//  UIViewController+userStastistics.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "UIViewController+userStastistics.h"
#import <objc/runtime.h>

#import "ZYYHookUtility.h"

@implementation UIViewController (userStastistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzleSelector = @selector(swiz_viewDidLoad);
        
        [ZYYHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzleSelector];
    });
}

- (void)inject_viewDidLoad {
    NSString *eventId = [self pageEventId];
    
    if (eventId.length > 0) {
        NSLog(@"当前的 eventId 为 %@", eventId);
    }
}

- (NSString *)pageEventId {
    
    NSString *className = NSStringFromClass([self class]);
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"demos" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    for (NSDictionary *dic in array) {
        if ([dic[@"vc"] isEqualToString:className]) {
            return dic[@"eventId"];
        }
    }

    return nil;
}

- (void)swiz_viewDidLoad {
    
    [self inject_viewDidLoad];
    
    [self swiz_viewDidLoad];
}


@end

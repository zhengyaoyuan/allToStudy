//
//  XXObject.m
//  debug-objc
//
//  Created by 郑尧元 on 2018/4/11.
//

#import "XXObject.h"

@implementation XXObject

- (void)hello {
    NSLog(@"%@ hello", NSStringFromClass(self.class));
}

@end

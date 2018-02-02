//
//  ZYYBaseModel+debug.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/1/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYBaseModel+debug.h"
#import <objc/runtime.h>
#import "ZYYHookUtility.h"


@implementation ZYYBaseModel (debug)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(description);
        SEL swizzleSelector = @selector(swiz_description);
        
        [ZYYHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzleSelector];
    });
}


- (NSString *)swiz_description {
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    NSString *str = [self swiz_description];
    
    [mutableString appendString:str];
    
    
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *attributes = property_getAttributes(properties[i]);
        
        NSString *str = [NSString stringWithUTF8String:propertyName];
        NSString *attributesStr = [NSString stringWithUTF8String:attributes];
        
//        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
//        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        
        [mutableString appendString:str];
        [mutableString appendString:attributesStr];
    }
//
//    Ivar *ivars = class_copyIvarList([self class], &count);
//
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(ivars + 1);
//        NSString *str = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        [mutableString appendString:str];
//    }
//
//    free(ivars);
    
    return mutableString;
}

@end

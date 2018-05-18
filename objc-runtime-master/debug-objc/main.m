
//  main.m
//  debug-objc
//
//  Created by closure on 2/24/16.
//
//

#import <Foundation/Foundation.h>
#import "XXObject.h"
#import <objc/runtime.h>

//void runtimeMethod(id self, SEL _cmd) {
//    NSLog(@" >> runtimeMethod");
//}
//
//@interface AClass : NSObject
//
//@end
//
//@implementation AClass
//
//
//@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 选择子 demo
//        XXObject *o = [[XXObject alloc] init];
//        __unused SEL sel = @selector(undefined_hello_method);
//        [o hello];
        
        // 消息发送 demo
//        XXObject *object = [[XXObject alloc] init];
//        [object hello];
//        [object hello];
        
        // 动态增加方法
//        class_addMethod([AClass class], @selector(runtimeMethod), (IMP)runtimeMethod, "v@:");
//        AClass *a = [[AClass alloc] init];
//        [a performSelector:@selector(runtimeMethod)];
//        NSLog(@"我成功了");

//        void (^blk)(void) = ^ {
//            NSLog(@"调用 block");
//        };
//
//        blk();

        // 截获自动变量

//        int dmy = 256;
//        int val = 10;
//        const char *fmt = "val = %d\n";
//        void (^blk)(void) = ^{printf(fmt,val);};
//
//        val = 2;
//        fmt = "These values were changed. val = %d\n";
//
//        blk();

        // __block
        __block int val = 10;
        void (^blk) (void) = ^ {val = 1;};
    }
    return 0;
}

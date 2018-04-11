//
//  ViewController.m
//  ZYYRuntimeDemo
//
//  Created by 郑尧元 on 2018/4/9.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "MyClass.h"

@interface Father : NSObject

@end

@implementation Father

- (void)hello {
    NSLog(@"父亲说好");
}

@end

@interface Son : Father

@end

@implementation Son

- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"%@", NSStringFromClass([self class]));
        // super 只是说明实现是从 super 去拿，但消息的接收者依旧是 self，也就是 son
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end

@interface Sark : NSObject

@property (nonatomic, copy) NSString *name;
- (void)speak;

@end

@implementation Sark

- (void)speak {
    NSLog(@"my name is %@", self.name);
}

@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    id cls = [Sark class];
//    void *obj = &cls;
//    [(__bridge id)obj speak];
    
//    [self judgeClass];
    
    [self howToFindSourceClassMethod];
    
}

// 有 category 时，如何找到初始的类的实例方法
- (void)howToFindSourceClassMethod {
    // 会用 category2 的实现
    MyClass *myClass = MyClass.new;
    [myClass printName];
    
    Class currentClass = [MyClass class];
    MyClass *my = [[MyClass alloc] init];
    
    if (currentClass) {
        unsigned int methodCount;
        // acquire all methods
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        // find last methods named printName，通过找到 methodList 里 最后一个方法名叫 “printName” 的！
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
            
            if ([NSStringFromSelector(@selector(printName)) isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        
        // 这段，我不太明白意思啊？
        typedef void (*fn)(id,SEL);
        if (lastImp != NULL) {
            // 函数指针 强转
            fn f = (fn)lastImp;
            // imp(obj, sel) 也是调用函数的一种方法！！
            f(my, lastSel);
        }
        // 别忘了释放掉
        free(methodList);
    }
}

- (void)memoryAddress {
    // 没懂意思，存疑
    // 注意 下面的代码必须放在 viewDidLoad 方法里，不能通过调方法！！！
    
    // obj 调用 speak，是否会崩溃？
    // 解释没看懂。。 要参照一下别人写的  obj 为什么是实例
    
    // 不崩溃，会输出什么呢？
    id cls = [Sark class];
    // obj 是一个无类型指针
    void *obj = &cls;
    // 强转成 id，为什么就是实例了呢？
    [(__bridge id)obj speak];
}

- (void)judgeClass {
    
    // isKindOfClass 是一个遍历的过程，从本类开始，向 superclass 方向靠去
    // isMemberOfClass 只比较一遍
    // 类对象，要从元类找起
    // 实例对象的话，要从类对象开始比较
    
    // +(void)isKindOfClass 会去找 消息接收者的 isa 指针（也就是类对象的 isa 指向，即元类），
    // 有一个 for 循环， 从元类与 NSObject 类对象开始比较，接着找元类的 superclass，即 NSObject，所以输出 1
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    // 输出 0
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    // 参照第一个输出，遍历顺序是 Sark meta class，接下来找 superclass NSObject meta class，然后是 NSObject， NSObject 没有 superclass
    // 输出 0
    // 如果改成 Sark 实例对象去比较的话，就会输出 1！！
    BOOL res3 = [(id)[Sark class] isKindOfClass:[Sark class]];
    // 输出 0
    BOOL res4 = [(id)[Sark class] isMemberOfClass:[Sark class]];
    
    NSLog(@"%d %d %d %d", res1, res2, res3, res4);

}

- (void)fatherAndSon {
    Father *father = Father.new;
    Son *son = Son.new;
    
    //    ((void(*)(id,SEL, id,id))objc_msgSend)(father, @selector(hello), nil, nil);
    // 有人说是映射到方法的 C 字符串，有地方说是结构体，不支持函数重载
    SEL selector = @selector(hello);
    objc_msgSend(father, selector);
    
    // objc_msgSendSuper 接收两个参数，第一个是 objc_super 结构体，第二个是 SEL
    // objc_super 里面包含了 1/消息的真正接收者，id  receiver 2/ Class super_class
    // 调用 super 的方法时，在 super_class 里查找 selector
}

@end

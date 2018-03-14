//
//  ViewController.m
//  ZYYRACDemo
//
//  Created by 郑尧元 on 2018/3/13.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TwoViewController.h"
#import "ZYYView.h"

@interface ViewController ()

@property (nonatomic, strong) RACCommand *command;
@property (nonatomic, strong) ZYYView *zyyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self signalCreate];
//    [self subjectCreate];
//    [self replaySubjectCreate];
//    [self goThroughArray];
//    [self goThroughDic];
//    [self commandDemo];
//    [self multicastConnectionDemo];
    
    [self.view addSubview:self.zyyView];
    [self practiceDemo];
}

- (void)signalCreate {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据：%@", x);
    }];
}

- (void)subjectCreate {
    RACSubject *subject = [RACSubject subject];
    
    // 这个信号是接收不到的，
    [subject sendNext:@"1"];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@", x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@", x);
    }];
    
    [subject sendNext:@"2"];
}

- (void)replaySubjectCreate {
    // RACSubject 既可以充当信号，也能自主发送信号
    // 允许有缓存事件
    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:1];
    
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 底层逻辑实现和 RACSignal 不一样
    // 保存每一个订阅者，订阅者中包含 subscribeNext block
    // sendNext 时，遍历订阅者，并调用 block
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@", x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@", x);
    }];
    
    [replaySubject sendNext:@3];
}

- (void)goThroughArray {
    NSArray *numbers = @[@1, @2, @3];
    
    // rac_sequence 实现遍历
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)goThroughDic {
    NSDictionary *dic = @{@"name": @"xmg", @"age": @18};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        
        NSLog(@"%@ %@", key, value);
    }];
}

- (void)mapDemo {
    NSDictionary *dic = @{@"name": @"xmg", @"age": @18};
    NSArray *dicArray = @[dic];
    
    NSArray *flags = [[dicArray.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return nil;
    }] array];
    
    NSLog(@"%@", flags);
}

- (void)commandDemo {
    // 用于处理事件的类，可以监控事件的执行过程
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"执行命令");
        
        // 必须返回信号，所以要用空信号来代替 nil
//        return [RACSignal empty];
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求数据1"];
            [subscriber sendNext:@"请求数据2"];
            
            // 这句话必须要有，不然就会一直处于执行中的状态！
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    // 必须强引用，因为是延迟发送的
    _command = command;
    
    // 3. 订阅信号，屌丝用法
    // executionSignals 是信号的信号。
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
    
    // 3. 订阅信号 高级用法 可以直接获取信号的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];

    // 4. 监听命令的状态，订阅命令状态的信号。分为正在执行和执行完成两种状态
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    
    // 5. 执行命令
    [self.command execute:@1];
}

- (void)multicastConnectionDemo {
    //  假设在一个信号中发送请求，每次订阅都会发送请求。这样会导致重复多次请求
    
    // 原本会出现的情况
    
//    // 1.创建请求信号
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//
//
//        NSLog(@"发送请求");
//
//        return nil;
//    }];
//    // 2.订阅信号
//    [signal subscribeNext:^(id x) {
//
//        NSLog(@"接收数据");
//
//    }];
//    // 2.订阅信号
//    [signal subscribeNext:^(id x) {
//
//        NSLog(@"接收数据");
//
//    }];
    
    // 3. 运行结果，会发送两次请求！！
    
    // 解决方法
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    // 2. 创建连接 作为中间层，共享底层一个订阅
    RACMulticastConnection *connect = [signal publish];
    
    // 3. 订阅  连接的信号，只会共享了
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一信号");
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二信号");
    }];
    
    // 连接，激活信号
    [connect connect];
}

- (void)practiceDemo {
    // 代理的简化版 把调用某个对象的方法的信息转换成信号
    [[self.zyyView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"zyySelector 执行了");
    }];
    
    // 2. KVO
    [[self.zyyView rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 3. 监听事件、通知、文本框的文字改变
    
    // 常见宏
    
    // 1. 属性绑定
    UILabel *label = [UILabel new];
    UITextField *textField = [UITextField new];
    RAC(label, text) = textField.rac_textSignal;
    
    // 2. KVO
    [RACObserve(self.view, center) subscribeNext:^(id  _Nullable x) {
        
    }];
    
    // 3. weak strong dance
    {
        @weakify(self)
        @strongify(self)
    }
    
    // 4. Tuple
    RACTuple *tuple = RACTuplePack(@10, @20);
    RACTupleUnpack(NSString *name, NSNumber *age) = tuple;
}


- (ZYYView *)zyyView {
    if (!_zyyView) {
        _zyyView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZYYView class]) owner:self options:nil][0];
        _zyyView.frame = CGRectMake(0.f, 100.f, 80.f, 80.f);
//        _zyyView = [[ZYYView alloc] initWithFrame:CGRectMake(0.f, 100.f, 80.f, 80.f)];
        _zyyView.backgroundColor = [UIColor redColor];
    }
    
    return _zyyView;
}

@end

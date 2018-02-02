//
//  ZYYRunloopObserverVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/29.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ZYYRunloopObserverVC.h"

@interface ZYYRunloopObserverVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) CFRunLoopObserverRef observer;

@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZYYRunloopObserverVC {
//    CFRunLoopObserverRef _observer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserverToCurrentRunloop];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addTimer];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopTimer];
}


- (void)dealloc
{
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observer, kCFRunLoopDefaultMode);
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runloopalive) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)runloopalive
{
    
}

- (void)addObserverToCurrentRunloop
{
    // 创建 observer

    __weak __typeof(self) wself = self;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"主线程 runloop 即将休眠 %@", @(++wself.count));
    });

    // 添加 observer 到 runloop 中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);  // 添加监听者，关键！
    CFRelease(observer); // 释放

    _observer = observer;
}

#pragma mark - UITableView



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}



@end

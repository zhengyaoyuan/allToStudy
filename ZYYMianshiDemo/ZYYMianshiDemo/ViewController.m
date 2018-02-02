//
//  ViewController.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2017/12/25.
//  Copyright © 2017年 郑尧元. All rights reserved.
//

#import "ViewController.h"

#import "ZYYMianshiCell.h"

#import "ZYYHookUtility.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *datasource;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"demos" ofType:@"plist"];
    self.datasource = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZYYMianshiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZYYMianshiCell class])];
    
    NSDictionary *dic = self.datasource[indexPath.row];
    
    [cell configCellWithTitle:dic[@"title"]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.datasource[indexPath.row];

    Class cls = NSClassFromString(dic[@"vc"]);
    NSObject *obj = [[cls alloc] init];
    
    if ([obj isKindOfClass:[UIViewController class]]) {
        
        UIViewController *vc = (UIViewController *)obj;
        vc.title = dic[@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

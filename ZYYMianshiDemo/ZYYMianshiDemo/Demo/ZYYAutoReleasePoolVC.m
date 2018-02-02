//
//  ZYYAutoReleasePoolVC.m
//  ZYYMianshiDemo
//
//  Created by 郑尧元 on 2018/1/11.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import "ZYYAutoReleasePoolVC.h"

@interface ZYYObject : NSObject

+ (instancetype)loadObject;

@end

@implementation ZYYObject

+ (instancetype)loadObject
{
    ZYYObject *object = [[ZYYObject alloc] init];
    return object;
}

- (void)dealloc
{
    
}

@end

@interface ZYYAutoReleasePoolVC ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ZYYAutoReleasePoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYYObject *zyyObject = [ZYYObject loadObject];
    
    self.array = [NSMutableArray array];
    
    [_array addObject:zyyObject];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZYYTestDemoTests.m
//  ZYYTestDemoTests
//
//  Created by 郑尧元 on 2018/3/12.
//  Copyright © 2018年 郑尧元. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ZYYTestDemoTests : XCTestCase

@end

@implementation ZYYTestDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
   
    NSInteger i = 3;
    XCTAssertEqual(i, 3, @"equal");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testVCIsExisting {
//    id delegate =  [UIApplication sharedApplication].delegate;
//    XCTAssertNil(delegate, @"cannot find delegate");
}

@end

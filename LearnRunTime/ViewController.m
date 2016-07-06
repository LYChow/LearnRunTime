//
//  ViewController.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/22/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "ViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "MessageInvocation.h"
#import "ReceiveNotificationVC.h"
#import "MessageForwardVC.h"
#import "ChangeMethodVC.h"
#import "NSObject+addProperty.h"
#import "Status.h"
#import "NSObject+Model.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //消息转发机制防止unrecognized selector 出现程序crash
//    MessageInvocation *invocation =[[MessageInvocation alloc] init];
    
    //推送的自定义跳转
//    ReceiveNotificationVC *receiveNotiVC=[ReceiveNotificationVC new];
//    [self.navigationController pushViewController:receiveNotiVC animated:YES];
    
    //替换方法的实现
//    ChangeMethodVC *changeMethodVC =[[ChangeMethodVC alloc] init];
//    [self.navigationController pushViewController:changeMethodVC animated:YES];
    
    //消息机制
//    MessageForwardVC *forwardVC =[[MessageForwardVC alloc] init];
//    [self.navigationController pushViewController:forwardVC animated:YES];

    //分类添加属性
//    NSObject *objc = [[NSObject alloc] init];
//    objc.name = @"123";
//    NSLog(@"%@",objc.name);
    
    //字典转模型
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArr = dict[@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        Status *status = [Status modelWithDictionary:dict];
        [statuses addObject:status];
    }
    
    //crashlytics测试
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 250, 100, 30);
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crashButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    

}

- (IBAction)crashButtonTapped:(id)sender {
    [[Crashlytics sharedInstance] crash];
}



@end

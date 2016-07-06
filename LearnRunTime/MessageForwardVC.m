//
//  MessageForwardVC.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "MessageForwardVC.h"
#import <objc/runtime.h>
#import "Person.h"
@interface MessageForwardVC ()

@end

@implementation MessageForwardVC

- (void)viewDidLoad {
    [super viewDidLoad];

    Person *p = [[Person alloc] init];
    //任何方法的调用,本质都是发消息
    [p eat];
    [p performSelector:@selector(eat)];
    
    // 让p发送消息
    //    objc_msgSend(p, @selector(eat));
    //    objc_msgSend(p, @selector(run:),10);
    
    // 类名调用类方法,本质类名转换成类对象
    //    [Person eat];
    
    // 获取类对象
    Class personClass = [Person class];
    
    //    [personClass performSelector:@selector(eat)];
    
    // 运行时
//    objc_msgSend(personClass, @selector(eat));
    
    
    [p performSelector:@selector(testMethod:) withObject:@"param name"];

}




@end

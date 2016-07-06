//
//  ChangeMethodVC.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "ChangeMethodVC.h"
#import "UIImage+changeMethod.h"

@interface ChangeMethodVC ()

@end

@implementation ChangeMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 本质:交换两个方法的实现imageNamed和exchange_imageNamed方法
    // 调用imageNamed其实就是调用exchange_imageNamed
    
    UIImage *image = [UIImage imageNamed:@"test.png"];
    
}


@end

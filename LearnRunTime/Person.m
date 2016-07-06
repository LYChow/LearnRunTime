//
//  Person.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
@implementation Person
- (void)eat
{
    NSLog(@"对象方法-吃东西");
}

+ (void)eat
{
    NSLog(@"类方法-吃东西");
}

- (void)run:(int)age
{
    NSLog(@"%d",age);
}

void addMethod(id self,SEL cmd,NSString  *str)
{
    NSLog(@"param = %@",str);
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{

    if (sel == @selector(testMethod:)) {
        class_addMethod([self class], sel, (IMP)addMethod, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

@end

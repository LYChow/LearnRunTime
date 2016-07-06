//
//  MessageForward.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/25/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "MessageForward.h"
#import <objc/runtime.h>
@implementation MessageForward


//-(void)method{
//    NSLog(@"%s",__func__);
//}

id dynamicMethodIMP1(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%s:动态添加的方法",__FUNCTION__);
    NSLog(@"%@", str);
    return @"1";
}

#pragma -mark 第一次机会:目标对象没找到对应的方法时,可提供一个其他的函数完成发消息的过程
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class], sel, (IMP)dynamicMethodIMP1, "@@:");
    BOOL result =[super resolveClassMethod:sel];
    result =YES;
    return result;
}

#pragma -mark 第二次机会:没有实现resolveInstanceMethod时,可以返回一个新的对象,去调用新对象的函数
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    id result = [super forwardingTargetForSelector:aSelector];
    return result;
}

#pragma -mark前两个方法都没有实现的话,会获得消息和返回值类型,如果返回nil发送doesNotRecognizeSelector程序crash,如果返回一个函数签名就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象.
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    id result =[super methodSignatureForSelector:aSelector];
    return result;
}



-(void)doesNotRecognizeSelector:(SEL)aSelector
{
    [super doesNotRecognizeSelector:aSelector];
}

@end

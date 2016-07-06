//
//  MessageInvocation.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/25/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "MessageInvocation.h"
#import "MessageForward.h"
//@class MessageForward;
#import <objc/runtime.h>

/*消息转发机制防止unrecognized selector 出现程序crash*/
/*
 objc在向一个对象发送消息时,runtime会根据对象的isa指针找到该对象所属的类,然后在该类和他父类的方法列表中找方法去运行,如果在顶层的父类方法中依然找不到运行的方法时,程序会挂掉并抛出unrecognized selector,在此之前objc运行时会给出3次拯救程序的机会
 
 第一次机会:objc运行时会调用+resolveInstanceMethod:或者 +resolveClassMethod:，让你有机会提供一个函数实现。如果你添加了函数，那运行时系统就会重新启动一次消息发送的过程，否则 ，运行时就会移到下一步，消息转发（Message Forwarding）.
 
 第二次机会:如果目标对象实现了-forwardingTargetForSelector:,runtime就会调用这个方法,给你把这个消息转发给其他对象的机会.这要这个对象不返回nil或self,整个消息发送的过程就会被重启,当然发送的对象就会变成你返回的那个.否则就继续Normal Fowarding.
 
 第三次机会:首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型.如果-methodSignatureForSelector:返回nil,runtime则会发出-doesNotRecognizeSelector:消息,程序crash.如果返回一个函数签名,runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象.
 */

@interface MessageInvocation()

@property(nonatomic,strong) MessageForward *target;
@end

@implementation MessageInvocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.target =[MessageForward new];
        [self performSelector:@selector(method) withObject:@"method"];
    }
    return self;
}


-(void)method{
    NSLog(@"%s",__func__);
}

id dynamicMethodIMP(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%s:动态添加的方法",__FUNCTION__);
    NSLog(@"%@", str);
    return @"1";
}

#pragma -mark 第一次机会:目标对象没找到对应的方法时,可提供一个其他的函数完成发消息的过程
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "@@:");
    BOOL result =[super resolveClassMethod:sel];
    result =YES;
    return result;
}

#pragma -mark 第二次机会:没有实现resolveInstanceMethod时,可以返回一个新的对象,去调用新对象的函数
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    id result = [super forwardingTargetForSelector:aSelector];
    result =self.target;
    return result;
}





#pragma -mark前两个方法都没有实现的话,会获得消息和返回值类型,如果返回nil发送doesNotRecognizeSelector程序crash,如果返回一个函数签名就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象.
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    id result =[super methodSignatureForSelector:aSelector];
    NSMethodSignature *sig =[NSMethodSignature signatureWithObjCTypes:"v@:"];
    result = sig;
    return result;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    anInvocation.selector = @selector(invocationTest);
    [self.target forwardInvocation:anInvocation];
}


-(void)doesNotRecognizeSelector:(SEL)aSelector
{
    [super doesNotRecognizeSelector:aSelector];
}


@end

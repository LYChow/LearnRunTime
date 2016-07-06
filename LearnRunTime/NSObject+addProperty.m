//
//  NSObject+addProperty.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "NSObject+addProperty.h"
#import <objc/runtime.h>

@implementation NSObject (addProperty)

-(void)setName:(NSString *)name
{
    // 添加属性,跟对象
    // 给某个对象产生关联,添加属性
    // object:给哪个对象添加属性
    // key:属性名,根据key去获取关联的对象 ,void * == id
    // value:关联的值
    // policy:策越

    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY);
}

-(NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}

@end

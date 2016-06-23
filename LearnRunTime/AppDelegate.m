//
//  AppDelegate.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/22/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//


/*
 根据推送通知传递来的参数,进行页面的跳转操作.用runtime实现
 */

#import "AppDelegate.h"
#import <objc/runtime.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSDictionary *params =@{@"Class":@"PushViewController",@"Property":@{
                                    @"type":@"11",@"channelId":@"111"
                                    }};
    //模拟通知推送传递过来参数进行跳转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self push:params];
    });
    
    return YES;
}

-(void)push:(NSDictionary *)params
{
    //根据params初始化一个新类
    NSString *className =params[@"Class"];
    
    const char *classChar = [className cStringUsingEncoding:[NSString defaultCStringEncoding]];
    Class class = objc_getClass(classChar);
    
    if (!class) {
        //创建一个类
        objc_allocateClassPair([NSObject class], classChar, 0);
         //注册创建的类
        objc_registerClassPair(class);
    }

    id instance =[[class alloc] init];
    
    //获取类对象的属性进行赋值
    NSDictionary *propertyList =params[@"Property"];
    [propertyList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       //传进来字典的key与instance的所有属性遍历匹配,一致时赋值
        if ([self instanceProperty:instance isEqualToParamKey:key]) {
            
            [instance setValue:obj forKey:key];
        }
        
    }];
    
    [self.window.rootViewController.navigationController pushViewController:instance animated:YES];
}

-(BOOL)instanceProperty:(id)instance isEqualToParamKey:(NSString *)key
{
    
    

    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        
        
        NSLog(@"property=%@ key=%@",[NSString stringWithFormat:@"%s",property_getName(property)],key);
        
        if ([[NSString stringWithFormat:@"%s",property_getName(property)] isEqualToString:key]) {
             free(properties);
            return YES;
        }
        
       
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }

    free(properties);
    return NO;
}

@end

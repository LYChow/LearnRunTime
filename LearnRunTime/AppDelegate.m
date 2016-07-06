//
//  AppDelegate.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/22/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//



#import "AppDelegate.h"

#import "ViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //crashlytics 测试崩溃收集crash日志
    [Fabric with:@[[Crashlytics class]]];


    
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *rootVC =[[ViewController alloc] init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end

//
//  UIImage+changeMethod.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "UIImage+changeMethod.h"
#import <objc/message.h>
@implementation UIImage (changeMethod)


+(void)load
{
    //class_getMethodImplementation:获取方法实现
    //class_getInstanceMethod:获取对象
    //class_getClassMethod:获取类方法
    //IMP:方法实现
    
    //Class获取哪个类的方法
    //SEL:获取方法名,根据SEL去对应的类找方法
    
    Method imageNameMethod =class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method exchangeImageNameMethod =class_getClassMethod([UIImage class], @selector(exchange_imageNamed:));
    
    //交换方法的实现
    method_exchangeImplementations(imageNameMethod, exchangeImageNameMethod);
}

+ (UIImage *)exchange_imageNamed:(NSString *)imageName
{
    UIImage *image =[UIImage exchange_imageNamed:imageName];
    if (imageName == nil) {
        NSLog(@"加载的image为nil");
    }
    return image;
};

@end

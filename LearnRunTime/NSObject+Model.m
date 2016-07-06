//
//  NSObject+Model.m
//  LearnRunTime
//
//  Created by LY'S MacBook Air on 6/28/16.
//  Copyright © 2016 LY'S MacBook Air. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)
+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    
    unsigned int outCount=0;
    //获取object的属性列表
   Ivar *ivarList = class_copyIvarList(self, &outCount);
    for (int i=0; i<outCount; i++) {
        //成员属性
        Ivar ivar = ivarList[i];
        
        //获取成员名
        NSString *propertyName =[NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //获取key,去_ 如:_name ---> name
        NSString *key =[propertyName substringFromIndex:1];
        
        //获取字典的value
        id value = dict[key];
        
        
        //成员变量的类型,获得这个值是为了看是否存在嵌套的模型,而不是字典
        
        NSString *propertyType =[NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        //考虑二级转换的问题
        //得到的值是字典,成员的类型不是字典,才是需要转换的模型
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {
            // @"@\"User\"" User
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            // User\"";
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
            Class modelClass =NSClassFromString(propertyType);
            if (modelClass) {
                [modelClass modelWithDictionary:value];
            }
        }
        
        
        if (value) {
        [objc setValue:value forKey:key];
        }

        
    }
    return objc;
    
}
@end

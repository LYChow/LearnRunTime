//
//  Status.m
//  05-Runtime(字典转模型KVC实现)
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "Status.h"

@implementation Status


+ (Status *)statusWithDict:(NSDictionary *)dict
{
    Status *status = [[self alloc] init];
    
    // KVC
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}


//处理服务器返回关键字,模型用别名的问题
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID =[value integerValue];
    }
    // key:没有找到key
    // value:没有找到key对应的值

}

@end

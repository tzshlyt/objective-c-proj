//
//  Manager.m
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import "Manager.h"

@implementation Manager

+ (id)sharedInstance {
    // 静态局部变量
    static Manager *instance = nil;
    
    // 通过dispatch_once 方式，确保在多线程下只被创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例，调用的是super方法, 因为重写了 allocWithZone 方法
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 重写方法【必不可少】
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

// 重写方法【必不可少】
- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

@end

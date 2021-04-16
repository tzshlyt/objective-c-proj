//
//  BridgeDemo.m
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import "BridgeDemo.h"
#import "BaseObjectA.h"
#import "ObjectA1.h"
#import "ObjectB1.h"

@interface BridgeDemo()

@property (nonatomic, strong) BaseObjectA *objA;

@end

@implementation BridgeDemo

/**
    A1 --> B1、B2       2 种
    A2 --> B1、B2       2 种
 */

- (void) fetch {
    // 创建具体 ClassA
    _objA = [[ObjectA1 alloc] init];
    
    // 创建具体 ClassB
    BaseObjectB *b1 = [[ObjectB1 alloc] init];
    
    // 将具体的 ClassB1 指定给抽象的 ClassB
    _objA.objB = b1;
    
    // 获取数据
    [_objA handle];
}

@end

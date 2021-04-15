//
//  Phone.m
//  runtime
//
//  Created by lan on 2021/3/21.
//

#import "Phone.h"
#import <objc/runtime.h>

@implementation Phone

// 方法交换
+ (void)load {
    Method test1 = class_getInstanceMethod(self, @selector(test1));
    Method test2 = class_getInstanceMethod(self, @selector(test2));
    method_exchangeImplementations(test1, test2);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", [self class]);
        NSLog(@"%@", [super class]);
    }
    return self;
}

//- (void)test {
//    NSLog(@"--- test");
//}

void testImp(void) {
    NSLog(@"test invoke");
}

- (void)test1 {
    NSLog(@"test1");
}

- (void)test2 {
    [self test2];
    NSLog(@"test2");
}

// 消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod");
    if (sel == @selector(test)) {
        NSLog(@"test resolve");
        
        // 动态添加方法的实现
        class_addMethod(self, @selector(test), testImp, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"methodSignatureForSelector");
    if (aSelector == @selector(test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
    if (anInvocation.selector == @selector(test)) {
        NSLog(@"##########");
    }
}

@end

//
//  BlockTest.m
//  objective-c-proj
//
//  Created by lan on 2021/4/13.
//

#import "BlockTest.h"

@interface BlockTest() {
    int (^_blk)(int);
}

@end

@implementation BlockTest

// 全局变量
int global_var = 4;

// 静态全局变量
static int static_global_var = 5;

- (void) method {
    // 基本类型的局部变量
    int var = 1;
    
    // 对象类型的局部变量
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    
    // 局部静态变量
    static int static_var = 3;
    
    void (^Block)(void) = ^ {
        NSLog(@"局部变量<基本数据类型> var %d", var);
        
        NSLog(@"局部变量<__unsafe_unretained 对象类型> var %@", unsafe_obj);
        NSLog(@"局部变量<__strong 对象类型> var %@", strong_obj);
        
        NSLog(@"静态变量 var %d", static_var);
        NSLog(@"全局变量 var %d", global_var);
        NSLog(@"全局静态变量 var %d", static_global_var);
    };
    global_var = 8;
    static_var = 9;
    Block();
}

- (void) method1 {
    __block int multiplier = 6;
    int(^Block)(int) = ^int(int num) {
        return num * multiplier;
    };
    multiplier = 4;
    NSLog(@"result is %d", Block(2));
}

- (void) method2 {
    int multiplier = 6;
    int(^Block)(int) = ^int(int num) {
        return num * multiplier;
    };
    multiplier = 4;
    NSLog(@"result is %d", Block(2));
}

- (void) method3 {
    __block int mutiplier = 10;
    _blk = ^int(int num) {
        return num * mutiplier;
    };
    mutiplier = 6;
    [self executeBlock];
}

- (void)executeBlock {
    int result = _blk(4);
    NSLog(@"result is %d", result);
}

@end

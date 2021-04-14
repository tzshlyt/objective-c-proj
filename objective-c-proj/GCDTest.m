//
//  GCDTest.m
//  objective-c-proj
//
//  Created by lan on 2021/4/14.
//

#import "GCDTest.h"

@implementation GCDTest

- (void) test {
    [self test1];
    [self test2];
    [self test3];
    [self test4];
}

// 同步串行队列
- (void) test1 {
    dispatch_queue_t serialDispatch = dispatch_queue_create("serial", nil);
    // 同步提交，意味着在当前线程执行
    dispatch_sync(serialDispatch , ^{
        NSLog(@"11 %@", [NSThread currentThread]);
    });
    NSLog(@"12 end");
}

// 同步并发队列
// 1. 同步提交，无论提交到串行队列还是并发队列，都是在当前线程去执行
// 2. 提交到并发队列的 block 可以并发执行
- (void) test2 {
    // 异步串行队列
    NSLog(@"gcd test2");
    dispatch_queue_t globalDispatch = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 同步提交，意味着在当前线程执行
    NSLog(@"21");
    dispatch_sync(globalDispatch , ^{
        NSLog(@"22 %@", [NSThread currentThread]);
        dispatch_sync(globalDispatch, ^{
            NSLog(@"23 %@", [NSThread currentThread]);
        });
        NSLog(@"24 %@", [NSThread currentThread]);
    });
    NSLog(@"25");
}

// 异步串行队列
- (void) test3 {
    NSLog(@"gcd test3");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"31 %@", [NSThread currentThread]);
    });
    NSLog(@"32");
}

// 异步并发
- (void) test4 {
    NSLog(@"gcd test4");
    dispatch_queue_t globalDispatch = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 异步分派到并发队列，gcd 会在底层线程池中某个线程去执行，默认是没有开启 runloop
    dispatch_async(globalDispatch, ^{
        NSLog(@"41 %@", [NSThread currentThread]);
        // 必须调用的线程有runloop，否则失效
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"43");
    });
    NSLog(@"44");
}

- (void) printLog {
    NSLog(@"42 %@", [NSThread currentThread]);
}

@end

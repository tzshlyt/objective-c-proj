//
//  RunLoopTest.m
//  objective-c-proj
//
//  Created by lan on 2021/4/14.
//

#import "RunLoopTest.h"

static NSThread *thread = nil;

// 标记是否要继续事件循环
static BOOL runAlways = YES;

@implementation RunLoopTest

+ (void) test {
    [self threadForDispatch];
}

+ (NSThread *)threadForDispatch {
    if (thread == nil) {
        @synchronized (self) {
            if (thread == nil) {
                // 创建线程
                thread = [[NSThread alloc] initWithTarget:self selector:@selector(runRequest) object:nil];
                [thread setName:@"com.test.thread"];
                // 启动
                [thread start];
            }
        }
    }
    return thread;
}

+ (void)runRequest {
    // 创建一个Source
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    // 创建RunLoop，同时向RunLoop的DefaultMode下面添加 Source
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    // 如果可以运行
    while (runAlways) {
        @autoreleasepool {
            // 令当前RunLoop运行在DefaultMode下面
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
        }
    }

    // 某一时机，静态变量runAlways = NO 时，可以保证跳出 RunLoop 线程退出
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

@end

//
//  UserCenter.m
//  objective-c-proj
//
//  Created by lan on 2021/4/14.
//

#import "UserCenter.h"

@interface UserCenter() {
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    // 用户数据中心，可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
}

@end

@implementation UserCenter

- (instancetype)init {
    self = [super init];
    if (self) {
        // 并发队列
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    // 同步读取指定数据，立刻返回调用结果
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    // 异步栅栏调用设置数据，实现多读单写
    dispatch_barrier_async(concurrent_queue, ^{
        [self->userCenterDic setObject:obj forKey:key];
    });
}

@end

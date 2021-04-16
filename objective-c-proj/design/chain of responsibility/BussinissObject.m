//
//  BussinissObject.m
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import "BussinissObject.h"

@implementation BussinissObject

// 责任链入口方法
- (void)handle:(ResultBlock)result {

    CompletionBlock completion = ^(BOOL handled) {
        // 当前业务处理掉，上抛结果
        if (handled) {
            result(self, handled);
        } else {
            // 沿责任链，指派给下一个业务处理
            if (self.nextBusiness) {
                [self.nextBusiness handle:result];
            } else {
                // 没有业务处理，上抛
                result(nil, NO);
            }
        }
    };

    // 当前业务进行处理
    [self handleBussiness: completion];
}

- (void)handleBussiness:(CompletionBlock)completion {
    // 业务处理
}

@end

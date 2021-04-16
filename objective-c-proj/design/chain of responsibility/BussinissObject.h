//
//  BussinissObject.h
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BussinissObject;
typedef void(^CompletionBlock)(BOOL handled);
typedef void(^ResultBlock)(BussinissObject *handler, BOOL handled);

@interface BussinissObject : NSObject

// 下一个响应者（响应链构成的关键）
@property (nonatomic, strong) BussinissObject *nextBusiness;

// 响应者的处理方法
- (void)handle:(ResultBlock)result;

// 各个业务在该方法当中做实际业务处理
- (void)handleBussiness:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END

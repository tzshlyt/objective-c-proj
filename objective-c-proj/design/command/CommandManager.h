//
//  CommandManager.h
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import <Foundation/Foundation.h>
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommandManager : NSObject

// 命令管理容器
@property (nonatomic, strong) NSMutableArray <Command*> *arrayCommands;

+ (instancetype) sharedInstance;

// 执行命令
+ (void)executeCommand:(Command *)cmd completion:(CommandCompletionCallBack)completion;

// 取消命令
+ (void)cancleCommand:(Command *)cmd;

@end

NS_ASSUME_NONNULL_END

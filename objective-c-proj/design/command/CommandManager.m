//
//  CommandManager.m
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import "CommandManager.h"


@implementation CommandManager

+ (instancetype)sharedInstance {
    static CommandManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

+ (void)executeCommand:(Command *)cmd completion :(CommandCompletionCallBack)completion {
    if (cmd) {
        if (![self _isExecutingCommand:cmd]) {
            // 添加命令
            [[[self sharedInstance] arrayCommands] addObject:cmd];
            cmd.completion = completion;
            
            // 执行命令
            [cmd execute];
        }
    }
}

// 取消命令
+ (void)cancleCommand:(Command *)cmd {
    if (cmd) {
        [[[self sharedInstance] arrayCommands] removeObject:cmd];
        
        [cmd cancel];
    }
}

+ (BOOL)_isExecutingCommand:(Command *)cmd {
    if (cmd) {
        NSArray *cmds = [[self sharedInstance] arrayCommands];
        for (Command *aCmd in cmds) {
            if (cmd == aCmd) {
                return YES;
            }
        }
    }
    return NO;
}


@end

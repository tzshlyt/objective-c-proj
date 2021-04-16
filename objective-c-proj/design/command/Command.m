//
//  Command.m
//  objective-c-proj
//
//  Created by lan on 2021/4/15.
//

#import "Command.h"
#import "CommandManager.h"

@implementation Command

- (void)execute {
    
    // override to subclass
    
    [self done];
}

- (void)cancel {
    self.completion = nil;
}

- (void)done {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completion) {
            _completion(self);
        }
        // 释放
        self.completion = nil;
        
        [[CommandManager sharedInstance].arrayCommands removeObject:self];
    });
}


@end

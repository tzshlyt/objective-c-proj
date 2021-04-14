//
//  ViewController.m
//  objective-c-proj
//
//  Created by lan on 2021/4/13.
//

#import "ViewController.h"
#import "BlockTest.h"
#import "GCDTest.h"
#import "RunLoopTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    BlockTest *block = [[BlockTest alloc] init];
    [block method];
    [block method1];
    [block method3];
    
    GCDTest *gcdTest = [[GCDTest alloc] init];
    [gcdTest test];
    
    [RunLoopTest test];
}


@end

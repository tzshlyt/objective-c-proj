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
#import "Phone.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    BlockTest *block = [[BlockTest alloc] init];
    [block method];
    
    GCDTest *gcdTest = [[GCDTest alloc] init];
    [gcdTest test];
    
    [RunLoopTest test];
    
    Phone *phone = [[Phone alloc] init];
    NSLog(@"--- %@",  [[phone superclass] class]);
    

//    [phone test];
    [phone performSelector:@selector(test)];
    
    [phone test1];
}


@end

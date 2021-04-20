//
//  Arc.m
//  objective-c-proj
//
//  Created by lan on 2021/4/20.
//

#import "Arc.h"

@implementation Arc

- (void)test {
    [self test1];
    [self test2];
    [self test3];
}



- (void)test1 {
    // id obj 和 id __strong 完全一样
    // id *obj 类推出来的 不是 id __strong *obj 而是 id __autoreleasing *obj
    // 即 NSObject **obj 并成为 NSObject * __autoreleasing *obj
    NSError *error = nil;
    NSError __strong **pError = &error; // 不添加 __strong 会产生编译错误
    // 赋值给对象指针时，所有权修饰符必须一致
    NSError __weak *error1 = nil;
    NSError * __weak *pError1 = &error1;
    
    // 使用参数取得对象
    NSError __strong *error2 = nil;
    // 编译器会自动的将源码转换
    // NSError __autoreleasing *tmp = error2;
    [self performOperationWithError:&error2];
    
    // 只有作为alloc/new/copy/mutableCopy方法的返回值取得对象时，能够自己生成并持有对象。
    // 其它情况即为取得非自己生成并持有的对象
}

- (void)test2 {
    id obj = [[NSObject alloc] init];
    
    // __bridge 转换其安全性与赋值给 __unsafe_unretained 修饰符相近，甚至更低
    // 如果管理时不注意赋值对象的所有者，就会因悬垂指针而导致程序崩溃
    void *p = (__bridge void *)obj;
    
    void *p1 = (__bridge_retained void *)obj;
    /* MRC 时相当于
     void *p1 = obj;
     [(id)p retain];
     */
    
    id obj2 = (__bridge_transfer id)p1;
    /* MRC 相当于
    id obj2 = (id)p1;
    [obj2 retain];
    [(id)p release];
     */
}

- (void)test3 {
    id obj = [[NSObject alloc] init];
    id __weak obj1 = obj;
    /* 编译器模拟代码 */
    /*
    id obj1;
    obj1 = 0;
    objc_storeWeak(&obj1, obj);
    objc_storeWeak(&obj1, 0);
     */
}

- (void)test4 {
}


- (BOOL)performOperationWithError:(NSError * __autoreleasing *)error {
    /* 错误发生 */
    *error = [[NSError alloc] init];
    return YES;
}

@end

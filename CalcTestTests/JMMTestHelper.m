//
//  JMMTestHelper.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import "JMMTestHelper.h"

@implementation JMMTestHelper

+ (void)swapInstanceMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2 {
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

+ (void)swapClassMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2 {
    Method method1 = class_getClassMethod(cls, sel1);
    Method method2 = class_getClassMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

@end

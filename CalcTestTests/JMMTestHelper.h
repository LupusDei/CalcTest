//
//  JMMTestHelper.h
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface JMMTestHelper : NSObject
+ (void)swapInstanceMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2;
+ (void)swapClassMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2;
@end

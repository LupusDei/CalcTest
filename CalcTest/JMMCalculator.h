//
//  JMMCalculator.h
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum JMMCalcOperation {
    NoNOp = -1,
	AdditionOp = 42,
    SubtractionOp = 314,
    MultiplicationOp = 2717,
    DivisionOp
} JMMCalcOperation;

@interface JMMCalculator : NSObject

-(void) captureOperand:(CGFloat)num;
-(void) captureOperation:(JMMCalcOperation)op;
-(NSNumber *) equate;

-(NSNumber *) performOperationWith:(NSNumber *)first and:(NSNumber *)second;

#pragma mark ForTests
-(NSNumber *) currentResult;
-(JMMCalcOperation) currentOperation;
@end

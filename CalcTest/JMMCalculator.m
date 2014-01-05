//
//  JMMCalculator.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import "JMMCalculator.h"

@interface JMMCalculator()
@property (nonatomic, strong) NSMutableArray *operands;
@property (nonatomic, strong) NSNumber *lastOperand;
@property JMMCalcOperation operation;
@end

@implementation JMMCalculator

-(instancetype) init {
    self = [super init];
    self.operands = [NSMutableArray array];
    return self;
}

-(void) captureOperand:(CGFloat)num {
	[self.operands addObject:[NSNumber numberWithFloat:num]];
}

-(void) captureOperation:(JMMCalcOperation)op {
    [self equate];
	self.operation = op;
}

-(NSNumber *) equate {
    NSNumber *secondOp;
    if ([self.operands count] < 1)
        return @0;
    if ([self.operands count] < 2) {
        if (self.lastOperand)
            secondOp = self.lastOperand;
        else
            return [self.operands lastObject];
    }
    else {
        secondOp = [self popOperand];
        self.lastOperand = secondOp;
    }
    NSNumber *firstOp = [self popOperand];
	NSNumber *result = [self performOperationWith:firstOp and:secondOp];
    [self.operands addObject:result];
    return result;
}

-(NSNumber *) performOperationWith:(NSNumber *)first and:(NSNumber *)second {
	CGFloat result;
    switch (self.operation) {
        case AdditionOp:
            result = first.floatValue + second.floatValue;
            break;
        case MultiplicationOp:
            result = first.floatValue * second.floatValue;
            break;
        default:
            result = second.floatValue;
            break;
    }
    return [NSNumber numberWithFloat:result];
}

-(NSNumber *) popOperand {
    NSNumber *last = [self.operands lastObject];
    [self.operands removeLastObject];
    return last;
}

#pragma mark ForTests
-(JMMCalcOperation) currentOperation {
    return self.operation;
}

-(NSNumber *) currentResult {
    return [self.operands lastObject];
}

@end

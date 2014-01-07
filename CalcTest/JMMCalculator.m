//
//  JMMCalculator.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import "JMMCalculator.h"

@interface JMMCalculator()

/// @name Private Properties
/**
 *  Array of operands. Used like a stack.
 */
@property (nonatomic, strong) NSMutableArray *operands;

/**
 * Storing the last operand to be used when pressing equals without pressing
 * and Op `UIButton`
 */
@property (nonatomic, strong) NSNumber *lastOperand;

/**
 *  The current `JMMCalcOperation`
 */
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
/// @name Private Methods

/**
 *  Pops last element from array, like a stack. Removes the element as well.
 *
 *  @return `NSNumber` with the last item in the opreands array.
 */
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

//
//  JMMCalculator.h
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @enum JMMCalcOperation
 *  
 *  Types for all possible operations
 *
 */
typedef NS_ENUM(NSInteger, JMMCalcOperation) {
    /**
     *  Not an Operation
     */
    NoNOp = -1,
	/**
	 *  Addition (+) operation
	 */
	AdditionOp = 42,
    /**
     *  Subtraction(-) operation
     */
    SubtractionOp = 314,
    /**
     *  Multiplication(*) operation
     */
    MultiplicationOp = 2717,
    /**
     *  Division(/) operation
     */
    DivisionOp
};

/**
 *  This class is created to handle the actual calculation for the calculator.
 *
 *  Most of the work is done in the performOperationWith:and: method. The rest
 *  of the methods just add Operands and Operations. This class can only handle 
 *  one `JMMCalcOperation` at a time.
 *
 *  @warning Division and Subtraction is not implemented.
 */
@interface JMMCalculator : NSObject

/// @name Public Methods

/**
 *  Add num to the operands stack
 *
 *  @param num `CGFloat` to be operated on
 */
-(void) captureOperand:(CGFloat)num;

/**
 *  Set the current operation to op.
 *
 *  @param op `JMMCalcOperation` to be set as the current operation
 */
-(void) captureOperation:(JMMCalcOperation)op;

/**
 *  Does a few sanity checks and then calls performOperationWith:and: with the
 *  appropriate two `NSNumber`s.
 *
 *  @return `NSNumber` with result from the operation
 */
-(NSNumber *) equate;

/**
 *  Does the Calculation.
 * 
 *  If `first` equaled 2,`second` equaled 3, and the current operation is `AddOp` then
 *  this method does `2 + 3`.
 * 
 *  @warning Division and Subtraction are not implemented yet.
 *
 *  @param first  Operand to the left of the operation
 *  @param second Operand to the right of the operation
 *
 *  @return `NSNumber` result of the calculation
 */
-(NSNumber *) performOperationWith:(NSNumber *)first and:(NSNumber *)second;

#pragma mark ForTests
/**
 *  Returns the last result in the operands stack
 *
 *  @return NSNumber with the result of the last operand
 */
-(NSNumber *) currentResult;

/**
 *  Returns the current operation
 *
 *  @return `JMMCalcOperation` with the current calculator operation
 */
-(JMMCalcOperation) currentOperation;
@end

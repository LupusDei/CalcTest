//
//  JMMCalculatorTests.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JMMCalculator.h"

@interface JMMCalculatorTests : XCTestCase

@end

@implementation JMMCalculatorTests {
    JMMCalculator *calc;
}

- (void)setUp
{
    [super setUp];
	calc = [JMMCalculator new];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

-(void) testItCanTakeAnInput {
 	[calc captureOperand:3];
	XCTAssertEqualObjects(@3,[calc currentResult]);
}

-(void) testItCanReturnTheResultWithOneOperand {
    [calc captureOperand:3];
	XCTAssertEqualObjects(@3,[calc equate]);
}

-(void) testItReturns0WhenThereAreNoOperands {
    XCTAssertEqualObjects(@0,[calc equate]);
}

-(void) testItCanTakeAnOperation {
    [calc captureOperation: AdditionOp];
    XCTAssertEqual(AdditionOp,[calc currentOperation]);
}

#pragma mark Performing Operations

-(void) testItUsesTheLastOperandWhenNoOperationHasBeenSet {
    NSNumber *result = [calc performOperationWith:@4 and:@2];
    XCTAssertEqualObjects(@2,result);
}

-(void) testItCanUseAnOperationToAddTwoNumbers {
    [calc captureOperation:AdditionOp];
    NSNumber *equate = [calc performOperationWith:@4 and:@2];
    XCTAssertEqualObjects(@6,equate);
}

-(void) testItCanMultiplyTwoNumbers {
    [calc captureOperation:MultiplicationOp];
    NSNumber *result = [calc performOperationWith:@4 and:@2];
    XCTAssertEqualObjects(@8,result);
}

#pragma mark Getting A Result
- (void) testTheCalculatorCanAddTwoOperands {
    [calc captureOperand:4];
    [calc captureOperation: AdditionOp];
    [calc captureOperand:2];
    
    XCTAssertEqualObjects(@6, [calc equate]);
}

- (void) testEquatingMultipleTimeAppliesTheSameOperationToThePreviousReultAndLastOperand {
    [calc captureOperand:4];
    [calc captureOperation: AdditionOp];
    [calc captureOperand:2];
    
    XCTAssertEqualObjects(@6, [calc equate]);
    XCTAssertEqualObjects(@8, [calc equate]);
    XCTAssertEqualObjects(@10, [calc equate]);
}

-(void) testCapturingASecondOperationCausesAnEquate {
    [calc captureOperand:4];
    [calc captureOperation: AdditionOp];
    [calc captureOperand:2];
    [calc captureOperation: MultiplicationOp];
    
    XCTAssertEqualObjects(@6,[calc currentResult]);
}

-(void) testUsingMultipleOperations {
    [calc captureOperand:4];
    [calc captureOperation: AdditionOp];
    [calc captureOperand:2];
    [calc captureOperation: MultiplicationOp];
    [calc captureOperand:3];

	XCTAssertEqualObjects(@18, [calc equate]);
    XCTAssertEqualObjects(@54, [calc equate]);
}

@end

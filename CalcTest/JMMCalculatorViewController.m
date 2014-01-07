//
//  JMMCalculatorViewController.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import "JMMCalculatorViewController.h"

@interface JMMCalculatorViewController ()

@end

@implementation JMMCalculatorViewController {
    BOOL operationJustPressed;
}

# pragma mark - UIViewController Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/// @name Private Methods

/**
 *  On view load, run setActionForButtons: on all buttons in `buttonView` and intialize a new [JMMCalculator](JMMCalculator)
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setActionForButtons:[self.buttonView subviews]];
    self.calculator = [JMMCalculator new];
}

#pragma mark - Public Methods

-(void) setActionForButtons:(NSArray *)buttons {
    for (UIButton *button in buttons) {
        [button addTarget:self action:@selector(calculatorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) calculatorButtonPressed:(UIButton *)button {
    [self handleButtonWithTitlePressed:[button titleForState:UIControlStateNormal]];
}

-(void) handleButtonWithTitlePressed:(NSString *)title {
    if ([title isEqualToString:@"="]) {
        [self handleEquals];
    }
    else if ([self buttonIsAnOperation:title]) {
		[self handleOperationPressed:title];
    }
    else {
		[self handleNumeralPressed:title];
    }
}

#pragma mark - Private Methods

/**
 *  When `UIButton` tapped is the equals button call [JMMCalculator equate] 
 *  and set the text of `displayLabel` to the result of the calculation.
 *
 *  Before equating, if no operation was just pressed add the current display text
 *  as an operand to the calculator.
 */

-(void) handleEquals {
    if (!operationJustPressed) {
        NSString *currentDisplayedText = self.displayLabel.text;
        [self.calculator captureOperand:currentDisplayedText.floatValue];
    }
    [self.calculator equate];
    [self.displayLabel setText:[NSString stringWithFormat:@"%@",[self.calculator currentResult]]];
    operationJustPressed = YES;
}

/**
 *  When `UIButton` tapped is an operand button, pass the operand to the [JMMCalculator captureOperand]
 *  and [JMMCalculator captureOperation] method. This operand will be used later for in the [JMMCalculator equate]
 *  operation.
 *
 *  @param title Title of the operation that was tapped. Passed in from handleButtonWithTitlePressed:
 */

-(void) handleOperationPressed:(NSString *)title {
    operationJustPressed = YES;
    NSString *currentDisplayedText = self.displayLabel.text;
    [self.calculator captureOperand:currentDisplayedText.floatValue];
    [self.calculator captureOperation:[self operationForString:title]];
    
}

/**
 *  When `UIButton` tapped is a numeral, concatenate numeral to the `displayLabel`
 *
 *  @param title The numeral that was pressed.
 */
-(void) handleNumeralPressed:(NSString *)title {
    NSString *currentDisplayedText = self.displayLabel.text;
    
    if ([currentDisplayedText isEqualToString:@"0"] || operationJustPressed)
        currentDisplayedText = title;
    else
        currentDisplayedText = [currentDisplayedText stringByAppendingString:title];
    
    [self.displayLabel setText:currentDisplayedText];
    operationJustPressed = NO;
}

/**
 *  Checks whether title is an operation by comparing it to the `JMMCalcOperation`
 *
 *  @param title The title of the `UIButton` pressed
 *
 *  @return `YES` or `NO`
 */
-(BOOL) buttonIsAnOperation:(NSString *)title {
    return [self operationForString:title] != NoNOp;
}

/**
 *  Translates the `NSString` representation of an operation to it's appropriate `JMMCalcOperation`
 *  
 *  @warning Division not implemented.
 *
 *  @param stringOp `NSString` calcualtor operation
 *
 *  @return The translated `JMMCalcOperation`
 */
-(JMMCalcOperation) operationForString:(NSString *)stringOp {
    if ([stringOp isEqualToString:@"+"])
        return AdditionOp;
    if ([stringOp isEqualToString:@"-"])
        return SubtractionOp;
    if ([stringOp isEqualToString:@"x"])
        return MultiplicationOp;
    return NoNOp;
}
@end

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

/// @name Documented Private Methods

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

-(void) handleEquals {
    if (!operationJustPressed) {
        NSString *currentDisplayedText = self.displayLabel.text;
        [self.calculator captureOperand:currentDisplayedText.floatValue];
    }
    [self.calculator equate];
    [self.displayLabel setText:[NSString stringWithFormat:@"%@",[self.calculator currentResult]]];
    operationJustPressed = YES;
}

-(void) handleOperationPressed:(NSString *)title {
    operationJustPressed = YES;
    NSString *currentDisplayedText = self.displayLabel.text;
    [self.calculator captureOperand:currentDisplayedText.floatValue];
    [self.calculator captureOperation:[self operationForString:title]];
    
}

-(void) handleNumeralPressed:(NSString *)title {
    NSString *currentDisplayedText = self.displayLabel.text;
    
    if ([currentDisplayedText isEqualToString:@"0"] || operationJustPressed)
        currentDisplayedText = title;
    else
        currentDisplayedText = [currentDisplayedText stringByAppendingString:title];
    
    [self.displayLabel setText:currentDisplayedText];
    operationJustPressed = NO;
}

-(BOOL) buttonIsAnOperation:(NSString *)title {
    return [self operationForString:title] != NoNOp;
}
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

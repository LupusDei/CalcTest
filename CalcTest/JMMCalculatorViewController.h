//
//  JMMCalculatorViewController.h
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMCalculator.h"

/**
 *  ViewController that takes button presses and hands them to `JMMCalculator` to calculate
 */

@interface JMMCalculatorViewController : UIViewController
/// @name UI Elements
/**
 *  The main `UILabel` for displaying results and input.
 */
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

/**
 *  Container view with all of the `UIButtons`.
 */
@property (weak, nonatomic) IBOutlet UIView *buttonView;

/// @name Public Properties
/**
 *  The running instance of `JMMCalculator` to do the heavy lifting.
 */
@property (nonatomic, strong) JMMCalculator *calculator;


/// @name Public Methods

/**
 *  Iterates over given `UIButton`s and sets their tap action to calculatorButtonPressed:
 *
 *  @param buttons All the buttons
 */
-(void) setActionForButtons:(NSArray *)buttons;

/**
 *  Receive calc `UIButton` tapped and asks `handleButtonWithTitlePressed:` to take the appropriate action.
 *
 *  @param button The `UIButton` that was tapped
 */
-(void) calculatorButtonPressed:(UIButton *)button;

/**
 *  This method decides which `UIButton` was tapped and calls the appropriate method.
 *
 *  @param title The title of the `UIButton` pressed. This could be an equal, operation, or numeral button.
 */
-(void) handleButtonWithTitlePressed:(NSString *)title;

@end

//
//  JMMCalculatorViewController.h
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMMCalculator.h"

@interface JMMCalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (nonatomic, strong) JMMCalculator *calculator;


-(void) setActionForButtons:(NSArray *)buttons;
-(void) calculatorButtonPressed:(UIButton *)button;
-(void) handleButtonWithTitlePressed:(NSString *)title;
@end

//
//  JMMCalculatorViewControllerTests.m
//  CalcTest
//
//  Created by Justin Martin on 1/4/14.
//  Copyright (c) 2014 JMM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JMMTestHelper.h"
#import "JMMCalculatorViewController.h"
#import "JMMCalculator.h"

BOOL actionsForButtonsWasCalled;
@interface JMMCalculatorViewControllerTests : XCTestCase
@end

@implementation UIViewController (Test)
//-(void) loadView{}
//-(void) viewDidLoad {
//    //Something like this could allow me to test my controller without side effects
//}
@end

@implementation JMMCalculatorViewController (Spy)
-(void) testSetActionForButtons:(NSArray *)buttons {
    actionsForButtonsWasCalled = YES;
}
@end

@interface MockButton : NSObject
@property (nonatomic, strong) id target;
@property SEL action;
@property UIControlEvents event;
@end
@implementation MockButton
-(void) addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    self.target = target;
    self.action = action;
    self.event = controlEvents;
}
@end

@implementation JMMCalculatorViewControllerTests {
    JMMCalculatorViewController *calcVC;
    UILabel *testLabel;
}

- (void)setUp
{
    [super setUp];
	calcVC = [JMMCalculatorViewController new];
    testLabel = [[UILabel alloc] init];
    [testLabel setText:@"0"]; // normal starting text for this label
    calcVC.displayLabel = testLabel; //using this test label since none of the views have been initialized
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

#pragma mark Initialization
-(void) testActionsForButtonsGetsCalledUponInitialization {
    actionsForButtonsWasCalled = NO;
    [JMMTestHelper swapInstanceMethodsForClass:[JMMCalculatorViewController class] selector:@selector(setActionForButtons:) andSelector:@selector(testSetActionForButtons:)];
    
    [calcVC viewDidLoad];
    
    XCTAssertTrue(actionsForButtonsWasCalled);
    
    [JMMTestHelper swapInstanceMethodsForClass:[JMMCalculatorViewController class] selector:@selector(testSetActionForButtons:) andSelector:@selector(setActionForButtons:)];
}

-(void) testActionForButtonsSetsTheTargetAndActionForEachButton {
    MockButton *button = [MockButton new];
    
    [calcVC setActionForButtons:@[button]];
 
    XCTAssertEqualObjects(calcVC,button.target);
    XCTAssertEqual(@selector(calculatorButtonPressed:),button.action);
    XCTAssertEqual(UIControlEventTouchUpInside,button.event);
}

#pragma mark Display
-(void) testItUpdatesTheDisplayWhenANumeralButtonIsPressed {
    [calcVC handleButtonWithTitlePressed:@"2"];
    
    XCTAssertEqualObjects(@"2",calcVC.displayLabel.text);
}
-(void) testItUpdatesTheDisplayWithMultipleNumbers {
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"2"];
    
    XCTAssertEqualObjects(@"22",calcVC.displayLabel.text);
}
-(void) testItClearsTheDisplayAndResetsToTheNewNumberAfterPressingAnOperation {
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"x"];
    [calcVC handleButtonWithTitlePressed:@"7"];
    
    XCTAssertEqualObjects(@"7",calcVC.displayLabel.text);
}
-(void) testItDisplaysTheResultAfterPressingTheEqualsButton {
    [calcVC viewDidLoad]; // this test uses the calculator - maybe should mock it out
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"x"];
    [calcVC handleButtonWithTitlePressed:@"7"];
    [calcVC handleButtonWithTitlePressed:@"="];
    
    XCTAssertEqualObjects(@"14",calcVC.displayLabel.text);
}
#pragma mark Calculator
-(void) testItHasACalculator {
    [calcVC viewDidLoad];
    
    XCTAssertNotNil(calcVC.calculator);
}

-(void) testItSetsTheOperandOnTheCalculatorWhenAnOperationIsPressed {
    [calcVC viewDidLoad]; //initialize the calculator
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"+"];
    
    XCTAssertEqualObjects(@22,[calcVC.calculator currentResult]);
}

-(void) testItSetsTheOperationOnTheCalculatorWhenAnOperationIsPressed {
    [calcVC viewDidLoad]; //initialize the calculator
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"x"];
    
    XCTAssertEqual(MultiplicationOp,[calcVC.calculator currentOperation]);
}

-(void) testItEquatesWhenTheEqualsButtonIsPressed {
    [calcVC viewDidLoad]; //initialize the calculator
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"x"];
    [calcVC handleButtonWithTitlePressed:@"3"];
    [calcVC handleButtonWithTitlePressed:@"="];
    
    XCTAssertEqualObjects(@6,[calcVC.calculator currentResult]);
}
-(void) testItEquatesUsingTheLastOperandPressed {
    [calcVC viewDidLoad]; //initialize the calculator
    [calcVC handleButtonWithTitlePressed:@"2"];
    [calcVC handleButtonWithTitlePressed:@"x"];
    [calcVC handleButtonWithTitlePressed:@"3"];
    [calcVC handleButtonWithTitlePressed:@"="];
    [calcVC handleButtonWithTitlePressed:@"="];
    
    XCTAssertEqualObjects(@18,[calcVC.calculator currentResult]);
}

@end

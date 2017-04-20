//
//  InputSelectionInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "InputSelectionInterfaceController.h"
#import "ExtensionDelegate.h"

@interface InputSelectionInterfaceController ()

@property ExtensionDelegate* delegate;

@property (weak, nonatomic) IBOutlet WKInterfaceButton* selectPrepButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* nextSectionButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* undoButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* pauseButton, *startButton;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer* timer;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* quesNumLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* secNumLabel;


-(IBAction)selectA;
-(IBAction)selectB;
-(IBAction)selectC;
-(IBAction)selectD;
-(IBAction)selectE;
-(IBAction)selectNexrSection;
-(IBAction)selectUndo;
-(IBAction)selectPause;
-(IBAction)selectStart;

@property NSInteger quesNumPrev, secNumPrev;

@end

@implementation InputSelectionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	_delegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	_delegate.userChoice.quesNumCurrent = 1;
	_delegate.userChoice.secNumCurrent = 1;
	[self upDateLabels];
	
	if (context != nil) {
			[_selectPrepButton setHidden:NO];
			[_pauseButton setHidden:YES];
			[_startButton setHidden:YES];
			[_timer setHidden:YES];
		
		

	} else {
		[_selectPrepButton setHidden:YES];
		[_startButton setHidden:YES];
		[_pauseButton setHidden:YES];
		[_timer setHidden:YES];
		if (_delegate.userChoice.isTimerEnabled) {
			[_pauseButton setHidden:NO];
			[_timer setHidden:NO];
			[_timer setDate: [NSDate dateWithTimeIntervalSinceNow:_delegate.userChoice.timeSecond]];
			[_timer start];
		}
		
	}
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)upDateLabels {
	[_quesNumLabel setText:[NSString stringWithFormat: @"Q.%d", _delegate.userChoice.quesNumCurrent]];
	[_secNumLabel setText:[NSString stringWithFormat: @"S.%d", _delegate.userChoice.secNumCurrent]];
}

- (void) saveChosenAnswer:(int16_t)Answer{
	
}

-(IBAction)selectA{
	[self saveChosenAnswer:1];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectB{
	[self saveChosenAnswer:2];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectC{
	[self saveChosenAnswer:3];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectD{
	[self saveChosenAnswer:4];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectE{
	[self saveChosenAnswer:5];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectNexrSection{
	_delegate.userChoice.quesNumCurrent = 1;
	_delegate.userChoice.secNumCurrent ++;
	[self upDateLabels];
}
-(IBAction)selectUndo{
	if (_delegate.userChoice.quesNumCurrent==1 & _delegate.userChoice.secNumCurrent!=1) {
		_delegate.userChoice.quesNumCurrent = _quesNumPrev;
		_delegate.userChoice.secNumCurrent --;
	} else if (_delegate.userChoice.quesNumCurrent > 1){
		_delegate.userChoice.quesNumCurrent --;
	}
	[self upDateLabels];
}
-(IBAction)selectPause{
	if (_delegate.userChoice.isTimerEnabled) {
		[_timer stop];
		[_pauseButton setHidden:YES];
		[_startButton setHidden:NO];
	}
}

-(IBAction)selectStart{
	if (_delegate.userChoice.isTimerEnabled) {
		[_timer start];
		[_pauseButton setHidden:NO];
		[_startButton setHidden:YES];
	}
}
@end




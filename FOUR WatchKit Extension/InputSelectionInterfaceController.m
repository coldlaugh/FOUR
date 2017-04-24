//
//  InputSelectionInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "InputSelectionInterfaceController.h"
#import "ExtensionDelegate.h"
#import "Data.h"

@interface InputSelectionInterfaceController ()

@property ExtensionDelegate* delegate;

@property (weak, nonatomic) IBOutlet WKInterfaceButton* answerButtonA, *answerButtonB, *answerButtonC, *answerButtonD, *answerButtonE;

@property (weak, nonatomic) IBOutlet WKInterfaceButton* selectPrepButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* nextSectionButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* undoButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton* pauseButton, *startButton;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer* timer;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* quesNumLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* secNumLabel;

@property NSDate* timerStart, *timerStop;


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
	
    NSString* contextString = (NSString*) context;
    
	if ([contextString isEqualToString:@"AddAnswer"]) {
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
            _timerStop = [NSDate dateWithTimeIntervalSinceNow:_delegate.userChoice.timeSecond];
            _timerStart = [NSDate dateWithTimeIntervalSinceNow:0];
			[_timer setDate: _timerStop];
			[_timer start];
		}
		
	}
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if (_delegate.userChoice.testNumChosen > 0) {
        [_selectPrepButton setTitle:[NSString stringWithFormat:@"prep %d",_delegate.userChoice.testNumChosen]];
        [_answerButtonA setEnabled:YES];
        [_answerButtonB setEnabled:YES];
        [_answerButtonC setEnabled:YES];
        [_answerButtonD setEnabled:YES];
        [_answerButtonE setEnabled:YES];
        
    } else {
        [_selectPrepButton setTitle:@"Select prep test"];
        [_answerButtonA setEnabled:NO];
        [_answerButtonB setEnabled:NO];
        [_answerButtonC setEnabled:NO];
        [_answerButtonD setEnabled:NO];
        [_answerButtonE setEnabled:NO];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)upDateLabels {
	[_quesNumLabel setText:[NSString stringWithFormat: @"Q.%d", _delegate.userChoice.quesNumCurrent]];
	[_secNumLabel setText:[NSString stringWithFormat: @"S.%d", _delegate.userChoice.secNumCurrent]];
}

- (void) saveChosenAnswer:(NSInteger)a question:(NSInteger)q section:(NSInteger)s prepTest:(NSInteger)p isTrueAnswer: (BOOL)t isUserLearning:(BOOL)l {
	
	NSString* entityName;
	

	if (t) {
		entityName = @"ANSWER";
    }
    else {
		entityName = @"USERANSWER";
	}
	
	Answer* oneAnswer = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_delegate.persistentContainer.viewContext];
	
	[oneAnswer setAnswer:a];
	[oneAnswer setQuestion:q];
	[oneAnswer setSection:s];
	[oneAnswer setPreptest:p];
	
	[_delegate saveChanges];
	
}

-(IBAction)selectA{
	[self saveChosenAnswer:1 question:_delegate.userChoice.quesNumCurrent section:_delegate.userChoice.secNumCurrent prepTest:_delegate.userChoice.testNumChosen isTrueAnswer:_delegate.userChoice.isTrueAnswerInput isUserLearning: _delegate.userChoice.isUserLearning];
	
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
	
}
-(IBAction)selectB{
	[self saveChosenAnswer:2 question:_delegate.userChoice.quesNumCurrent section:_delegate.userChoice.secNumCurrent prepTest:_delegate.userChoice.testNumChosen isTrueAnswer:_delegate.userChoice.isTrueAnswerInput isUserLearning: _delegate.userChoice.isUserLearning];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectC{
	[self saveChosenAnswer:3 question:_delegate.userChoice.quesNumCurrent section:_delegate.userChoice.secNumCurrent prepTest:_delegate.userChoice.testNumChosen isTrueAnswer:_delegate.userChoice.isTrueAnswerInput isUserLearning: _delegate.userChoice.isUserLearning];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectD{
	[self saveChosenAnswer:4 question:_delegate.userChoice.quesNumCurrent section:_delegate.userChoice.secNumCurrent prepTest:_delegate.userChoice.testNumChosen isTrueAnswer:_delegate.userChoice.isTrueAnswerInput isUserLearning: _delegate.userChoice.isUserLearning];
	_quesNumPrev = _delegate.userChoice.quesNumCurrent;
	_delegate.userChoice.quesNumCurrent++;
	[self upDateLabels];
}
-(IBAction)selectE{
	[self saveChosenAnswer:5 question:_delegate.userChoice.quesNumCurrent section:_delegate.userChoice.secNumCurrent prepTest:_delegate.userChoice.testNumChosen isTrueAnswer:_delegate.userChoice.isTrueAnswerInput isUserLearning: _delegate.userChoice.isUserLearning];
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
        _timerStart = [NSDate dateWithTimeIntervalSinceNow:0];
		[_pauseButton setHidden:YES];
		[_startButton setHidden:NO];
	}
}

-(IBAction)selectStart{
	if (_delegate.userChoice.isTimerEnabled) {
        
        _timerStop = [_timerStop dateByAddingTimeInterval:
                      [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:_timerStart]
                      ];
        
        [_timer setDate: _timerStop];
        
		[_timer start];
        
		[_pauseButton setHidden:NO];
		[_startButton setHidden:YES];
	}
}
@end




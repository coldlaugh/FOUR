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

@interface InputSelectionInterfaceController (){
    NSInteger learnCount;
    NSDate* timerStart, *timerStop;
    ExtensionDelegate* delegate;
    NSMutableArray* learnArray;
}


@property (weak, nonatomic) IBOutlet WKInterfaceButton* answerButtonA, *answerButtonB, *answerButtonC, *answerButtonD, *answerButtonE;

@property (weak, nonatomic) IBOutlet WKInterfaceButton* selectPrepButton, *nextSectionButton, *undoButton, *pauseButton, *startButton, *showButton;

@property (weak, nonatomic) IBOutlet WKInterfaceGroup*  statGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer* timer;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel* quesNumLabel, *secNumLabel, *correctCountLabel, *totalCountLabel, *learnLabel;

@property BOOL needUpdateLearnArray; // if YES, update learn array



-(IBAction)selectA;
-(IBAction)selectB;
-(IBAction)selectC;
-(IBAction)selectD;
-(IBAction)selectE;
-(IBAction)selectNextSection;
-(IBAction)selectUndo;
-(IBAction)selectPause;
-(IBAction)selectStart;
-(IBAction)selectShowAnswer;

@property NSInteger quesNumPrev, secNumPrev;



@end

@implementation InputSelectionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	delegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	delegate.userChoice.quesNumCurrent = 1;
	delegate.userChoice.secNumCurrent = 1;
	
    NSString* contextString = (NSString*) context;
    
	if ([contextString isEqualToString:@"AddAnswer"]) {
			[_selectPrepButton setHidden:NO];
			[_pauseButton setHidden:YES];
			[_startButton setHidden:YES];
			[_timer setHidden:YES];
            [_showButton setHidden:YES];
            [_statGroup setHidden:YES];
        
    }
    else if ([contextString isEqualToString:@"Learn"]){
        [_selectPrepButton setHidden:NO];
        [_pauseButton setHidden:YES];
        [_startButton setHidden:YES];
        [_timer setHidden:YES];
        [_showButton setHidden:NO];
        [_statGroup setHidden:NO];
        [_nextSectionButton setHidden:YES];
        [_undoButton setHidden:YES];
        
        // if testNum is chosen, prepare learning questions
        if (delegate.userChoice.testNumChosen > 0) {
            [self prepareLearningQuestion];
        }
        
        _needUpdateLearnArray = YES;
        learnCount = 0;
        
    }
    else {
		[_selectPrepButton setHidden:YES];
		[_startButton setHidden:YES];
		[_pauseButton setHidden:YES];
		[_timer setHidden:YES];
        [_showButton setHidden:YES];
        [_statGroup setHidden:YES];
		if (delegate.userChoice.isTimerEnabled) {
			[_pauseButton setHidden:NO];
			[_timer setHidden:NO];
            timerStop = [NSDate dateWithTimeIntervalSinceNow:delegate.userChoice.timeSecond];
            timerStart = [NSDate dateWithTimeIntervalSinceNow:0];
			[_timer setDate: timerStop];
			[_timer start];
		}
		
	}
    
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if (delegate.userChoice.testNumChosen > 0) {
        [_selectPrepButton setTitle:[NSString stringWithFormat:@"prep %d",delegate.userChoice.testNumChosen]];
        
        [_answerButtonA setEnabled:YES];
        [_answerButtonB setEnabled:YES];
        [_answerButtonC setEnabled:YES];
        [_answerButtonD setEnabled:YES];
        [_answerButtonE setEnabled:YES];
        
        // if learning, prepare learning questions
        
        if (delegate.userChoice.isUserLearning) {
            
            if (_needUpdateLearnArray) {
                [self prepareLearningQuestion];
            }
            
            if (delegate.userChoice.quesNumCurrent > 0) {
                
                [_nextSectionButton setHidden:YES];
                
            }
            
        }
        
        
        
    } else {
        
        [_selectPrepButton setTitle:@"Select prep test"];
        [_answerButtonA setEnabled:NO];
        [_answerButtonB setEnabled:NO];
        [_answerButtonC setEnabled:NO];
        [_answerButtonD setEnabled:NO];
        [_answerButtonE setEnabled:NO];
        
    }
    
    if (delegate.userChoice.isUserLearning){
        if (learnArray.count < 2) {
            // no answer in this section
            [_answerButtonA setEnabled:NO];
            [_answerButtonB setEnabled:NO];
            [_answerButtonC setEnabled:NO];
            [_answerButtonD setEnabled:NO];
            [_answerButtonE setEnabled:NO];
            [_nextSectionButton setHidden:NO];
        }else if (learnArray[delegate.userChoice.quesNumCurrent]==0)
        {
            [self nextQuestion];
        } // skip questions that has been answered correctly
    }
    
    
    [self upDateLabels];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)upDateLabels {
	[_quesNumLabel setText:[NSString stringWithFormat: @"Q.%d", delegate.userChoice.quesNumCurrent]];
	[_secNumLabel setText:[NSString stringWithFormat: @"S.%d", delegate.userChoice.secNumCurrent]];
    if (delegate.userChoice.isUserLearning) {
        [_learnLabel setText:[NSString stringWithFormat:@"%d + ",learnCount]];
    }
    
}

- (void) saveChosenAnswer:(NSInteger)a question:(NSInteger)q section:(NSInteger)s prepTest:(NSInteger)p isTrueAnswer: (BOOL)t isUserLearning:(BOOL)l {
	
	NSString* entityName;
	

	if (t) {
		entityName = @"ANSWER";
    } else if (l){
        entityName = @"LEARNANSWER";
    } else {
		entityName = @"USERANSWER";
	}
	
	Answer* oneAnswer = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:delegate.persistentContainer.viewContext];
	
	[oneAnswer setAnswer:a];
	[oneAnswer setQuestion:q];
	[oneAnswer setSection:s];
	[oneAnswer setPreptest:p];
    [oneAnswer setTime:[NSDate date]];
	
	[delegate saveChanges];
	
}

-(void) selectAnswer: (NSInteger) answer{
    
    // save answer to database
    

    
    // if learning, compare with correct answer,
    // correct -> next question & show congrat page
    // wrong -> stay in this question & show sorry page
    
    
    if (delegate.userChoice.isUserLearning) {
        
        // Check if answer is correct
        
        NSNumber* n = learnArray[delegate.userChoice.quesNumCurrent];
        
        NSInteger trueAnswer = n.integerValue;
        if (trueAnswer == answer) {
            [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
            [self saveChosenAnswer: answer question:delegate.userChoice.quesNumCurrent section:delegate.userChoice.secNumCurrent prepTest:delegate.userChoice.testNumChosen isTrueAnswer:delegate.userChoice.isTrueAnswerInput isUserLearning: delegate.userChoice.isUserLearning];
            learnCount ++;
            [self nextQuestion];
        }else{
            [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick]; // click to indicate input finished
        }
        
        
    } else {
        // update to next question
        [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick]; // click to indicate input finished
        [self saveChosenAnswer: answer question:delegate.userChoice.quesNumCurrent section:delegate.userChoice.secNumCurrent prepTest:delegate.userChoice.testNumChosen isTrueAnswer:delegate.userChoice.isTrueAnswerInput isUserLearning: delegate.userChoice.isUserLearning];
        [self nextQuestion];
    }
    
    // update displaying labels
    [self upDateLabels];

}

-(IBAction)selectA{
    
    [self selectAnswer:1];
	
}
-(IBAction)selectB{
    
	[self selectAnswer:2];

}
-(IBAction)selectC{
    
    [self selectAnswer:3];
    
    }
-(IBAction)selectD{
	
    [self selectAnswer:4];
    
}
-(IBAction)selectE{
	
    [self selectAnswer:5];
    
}

-(IBAction)selectPrep{
    
    delegate.userChoice.quesNumCurrent = 0;
    
}
-(IBAction)selectNextSection{
    
	delegate.userChoice.quesNumCurrent = 1;
	delegate.userChoice.secNumCurrent ++;
    
	[self upDateLabels];
    
    if (delegate.userChoice.isUserLearning) {
        
        learnCount = 0;
        [self willActivate];
        
    }
    
}
-(IBAction)selectUndo{
	if (delegate.userChoice.quesNumCurrent==1 & delegate.userChoice.secNumCurrent!=1) {
		delegate.userChoice.quesNumCurrent = _quesNumPrev;
		delegate.userChoice.secNumCurrent --;
	} else if (delegate.userChoice.quesNumCurrent > 1){
		delegate.userChoice.quesNumCurrent --;
	}
	[self upDateLabels];
}
-(IBAction)selectPause{
    
    // hide pause button and show start botton
    
	if (delegate.userChoice.isTimerEnabled) {
        
        [_timer stop];
        
        // record the action time for correct timer restart
        
        timerStart = [NSDate dateWithTimeIntervalSinceNow:0];
        
		[_pauseButton setHidden:YES];
		[_startButton setHidden:NO];
	}
    
}

-(IBAction)selectStart{
    
	if (delegate.userChoice.isTimerEnabled) {
        
        timerStop = [timerStop dateByAddingTimeInterval:
                      [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceDate:timerStart]
                      ];
        
        [_timer setDate: timerStop];
        
		[_timer start];
        
		[_pauseButton setHidden:NO];
		[_startButton setHidden:YES];
        
	}
}

-(IBAction)selectShowAnswer{
    
}

-(void) nextQuestion{
    
    if (delegate.userChoice.isTrueAnswerInput) {
        
        _quesNumPrev = delegate.userChoice.quesNumCurrent;
        delegate.userChoice.quesNumCurrent++;
        
    } else if (delegate.userChoice.isUserLearning)
    {
        
        //if learning, retrive next question from learnArray
        delegate.userChoice.quesNumCurrent++;
        
        //when q number excees prepared learn array, update next section button to green color
        
        if (delegate.userChoice.quesNumCurrent >= learnArray.count)
        
        {
            
            delegate.userChoice.quesNumCurrent = 0;
            [_nextSectionButton setBackgroundColor:[UIColor colorWithRed:(67.0/255.0) green:(217.0/255.0) blue:(100.0/255.0) alpha:1.0]];
            [_nextSectionButton setHidden:NO];
        
            
        }
        
        
        while (learnArray[delegate.userChoice.quesNumCurrent] == 0)
        {
            delegate.userChoice.quesNumCurrent++;
        }
        
        
        
        
    } else {
        _quesNumPrev = delegate.userChoice.quesNumCurrent;
        delegate.userChoice.quesNumCurrent++;
        [_nextSectionButton setBackgroundColor:[UIColor greenColor]];
        [_nextSectionButton setHidden:YES];

    }
    
}

-(void) prepareLearningQuestion{
    
    // fetch results comparing user choice and true answer;
    
    NSFetchRequest* answerRequest = [NSFetchRequest fetchRequestWithEntityName:@"ANSWER"];
    
    NSFetchRequest* userAnswerRequest = [NSFetchRequest fetchRequestWithEntityName:@"USERANSWER"];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"preptest == %d && section == %d",delegate.userChoice.testNumChosen,delegate.userChoice.secNumCurrent];
    
    NSSortDescriptor* dateSort, *questionSort;
    
    
    NSError* error;
    
    dateSort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    questionSort = [NSSortDescriptor sortDescriptorWithKey:@"question" ascending:YES];
    
    //configure fetch requests
    
    [answerRequest setPredicate:predicate];
    [answerRequest setSortDescriptors:@[questionSort,dateSort]];
    [userAnswerRequest setPredicate:predicate];
    [userAnswerRequest setSortDescriptors:@[questionSort,dateSort]];
    
    NSArray* answerResult = [delegate.persistentContainer.viewContext executeFetchRequest:answerRequest error:&error];
    
    //handle error
    
    if (error != nil) {
        abort();
    }
    
    
    NSArray* userAnswerResult = [delegate.persistentContainer.viewContext executeFetchRequest:userAnswerRequest error:&error];
    
    //handle error
    
    if (error != nil) {
        abort();
    }
    
    
    // define default array length
    
    NSInteger arrayLimit = 60;
    
    // pull out lastest true answer
    
    NSInteger answerCount = 0;
    NSInteger answerArray[arrayLimit];
    
    for (int i = 0; i<answerResult.count; i++) {
        
        Answer* item = answerResult[i];
        
        while (item.question > (answerCount+1)) {
            answerArray[answerCount] = -1;
            answerCount ++;
        }
        
        if (item.question == (answerCount+1)) {
            answerArray[answerCount] = item.answer;
            answerCount ++;
        }
    }
    
    
    // pull out lastest true answer
    
    NSInteger userAnswerCount = 0;
    NSInteger userAnswerArray[arrayLimit];
    
    for (int i = 0; i<userAnswerResult.count; i++) {
        
        Answer* item = userAnswerResult[i];
        
        
        while (item.question > (userAnswerCount+1)) {
            userAnswerArray[userAnswerCount] = -1;
            userAnswerCount ++;
        }
        
        
        if (item.question == (userAnswerCount+1)) {
            userAnswerArray[userAnswerCount] = item.answer;
            userAnswerCount ++;
        }
    }
    
    
    
    
    // if there are more answers than true answers
    
    if (answerCount < userAnswerCount){
        [self askUserToContinue];
    }
    
    
    //compare user answer with true answer
    
    learnArray = [NSMutableArray arrayWithCapacity:100];
    
    NSInteger correctCount = 0;
    
    NSNumber* n = [NSNumber numberWithInteger:0];
    [learnArray addObject:n];
    
    for (int i = 0; i < answerCount; i++){
        if (i >= userAnswerCount) {
            NSNumber* n = [NSNumber numberWithInteger:answerArray[i]];
            [learnArray addObject:n];
        } else if (answerArray[i] != userAnswerArray[i] && answerArray[i]>0) {
            
            NSNumber* n = [NSNumber numberWithInteger:answerArray[i]];
            [learnArray addObject:n];
            
            
        } else {
            
            NSNumber* n = [NSNumber numberWithInteger:0];
            [learnArray addObject:n];
            
            correctCount++;
            
        }
    }
    
    // update label display
    
    
    [_correctCountLabel setText:[NSString stringWithFormat: @"%d", correctCount]];
    
    [_totalCountLabel setText:[NSString stringWithFormat:@"/%d",answerCount]];
    
    
     
    
    
}
    

- (void) askUserToContinue {
    
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier
{
    if ([segueIdentifier isEqualToString:@"TestPicker"] & delegate.userChoice.isUserLearning) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ANSWER"];
        [request setPropertiesToFetch:@[@"preptest"]];
        [request setReturnsDistinctResults:YES];
        [request setResultType:NSDictionaryResultType];
        NSSortDescriptor* prepSort = [NSSortDescriptor sortDescriptorWithKey:@"preptest" ascending:YES];
        [request setSortDescriptors:@[prepSort]];
        NSError* error;
        NSArray* result = [delegate.persistentContainer.viewContext executeFetchRequest:request error:&error];
        NSMutableArray* testArray = [NSMutableArray arrayWithCapacity:100];
        for (int i = 0; i<=result.count; i++) {
            if (i == 0) {
                NSNumber* n = [NSNumber numberWithInt: i];
                [testArray addObject:n];
            }else{
                NSNumber* value = [(NSDictionary*)result[i-1] objectForKey:@"preptest"];
                NSNumber* n = [NSNumber numberWithInteger:value.integerValue];
                if (n.integerValue > 0) {
                    [testArray addObject:n];
                }
            }
        }
        return testArray;
        
    }else if ([segueIdentifier isEqualToString:@"ShowAnswer"]){
        
        if (delegate.userChoice.quesNumCurrent<learnArray.count){
        return learnArray[delegate.userChoice.quesNumCurrent];
        } else {
            return nil;
        }
        
    }else {
        return nil;
    }
}

@end




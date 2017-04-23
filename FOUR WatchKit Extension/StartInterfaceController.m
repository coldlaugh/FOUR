//
//  startInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "StartInterfaceController.h"
#import "ExtensionDelegate.h"

@interface StartInterfaceController ()

@property ExtensionDelegate* appDelegate;

@property (weak,nonatomic) IBOutlet WKInterfaceButton* timerButton, *preptestButton, *startButton;


@end

@implementation StartInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	
	// Assign pointer to app delegate
	
	_appDelegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	
	
	
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
	
	if (_appDelegate.userChoice.isTimerEnabled) {
		[_timerButton setTitle:[NSString stringWithFormat: @"Timer\r%d min",(int)(_appDelegate.userChoice.timeSecond/60)]];
	} else{
		[_timerButton setTitle:@"Set timer"];
	}
	
	if (_appDelegate.userChoice.testNumChosen > 0){
		[_preptestButton setTitle:[NSString stringWithFormat:@"Prep %d",_appDelegate.userChoice.testNumChosen]];
		[_startButton setEnabled:YES];
	} else{
		[_preptestButton setTitle:@"Set prep test"];
		[_startButton setEnabled:NO];
	}
	
	
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier{
	
//	NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"NSObject"]];
//	if ([segueIdentifier isEqualToString:@"start"]) {
//		_appDelegate.userChoice.timer = [NSTimer scheduledTimerWithTimeInterval:_appDelegate.userChoice.timeSecond invocation:invocation repeats:NO];
//	}
	return nil;
}

@end




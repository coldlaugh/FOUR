//
//  TimerInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "TimerInterfaceController.h"
#import "ExtensionDelegate.h"


@interface TimerInterfaceController ()


@property (weak) IBOutlet WKInterfacePicker* timerPicker;

@property ExtensionDelegate* appDelegate;

- (IBAction)timerPickerAction:(NSInteger)index;

@end

@implementation TimerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	NSInteger timerLimit = 300;
	
	WKPickerItem *pickerItemArray[timerLimit];
	
	for (NSInteger i = 0; i<timerLimit; i++) {
		pickerItemArray[i] = [WKPickerItem alloc];
		if (i == 0) {
			[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"No Timer"]];
		}
		else {
			[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"%ld min", (long) i]];
		}
	};
	
	NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: timerLimit];
	
	[_timerPicker setItems:pickerItem];
	
	// Assign pointer to the delegate
	
	_appDelegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
	
	[_timerPicker setSelectedItemIndex: (int)(_appDelegate.userChoice.timeSecond/60)];
	
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)timerPickerAction:(NSInteger)index{
	if (index == 0) {
		_appDelegate.userChoice.isTimerEnabled = NO;
	}
	else{
		_appDelegate.userChoice.isTimerEnabled = YES;
		_appDelegate.userChoice.timeSecond = index * 60.0;
	}
}



@end




//
//  addAnswerInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "addAnswerInterfaceController.h"

@interface addAnswerInterfaceController ()

@property (weak) IBOutlet WKInterfacePicker* testNumPicker;

@end

@implementation addAnswerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	// Configure testNumPicker;
	
	NSInteger testLimit = 80;
	
	WKPickerItem *pickerItemArray[testLimit];
	
	for (NSInteger i = 0; i<testLimit; i++) {
		[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"Test %ld", (long) i]];
	};
	
	NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: testLimit];
	
	[_testNumPicker setItems:pickerItem];
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




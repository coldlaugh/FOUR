//
//  addAnswerInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "TestPickerInterfaceController.h"
#import "ExtensionDelegate.h"

@interface TestPickerInterfaceController ()

@property (weak) IBOutlet WKInterfacePicker* testNumPicker;
@property NSInteger testNumberChosen;
@property ExtensionDelegate* appDelegate;
- (IBAction)testNumPickerAction:(NSInteger)index;

@end

@implementation TestPickerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	// Configure testNumPicker;
	
	NSInteger testLimit = 80;
	
	WKPickerItem *pickerItemArray[testLimit];
	
	for (NSInteger i = 0; i<testLimit; i++) {
		pickerItemArray[i] = [WKPickerItem alloc];
		[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"Test %ld", (long) i]];
	};
	
	NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: testLimit];
	
	[_testNumPicker setItems:pickerItem];
	
	// Assign pointer to the delegate
	
	_appDelegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


#pragma mark picker action


- (IBAction)testNumPickerAction:(NSInteger)index{
	_appDelegate.userChoice.testNumChosen = index;
}


@end



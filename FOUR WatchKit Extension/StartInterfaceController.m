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

@property (weak) IBOutlet WKInterfacePicker* testNumPicker;
@property ExtensionDelegate* appDelegate;

- (IBAction)testPickerAction:(NSInteger)index;


@end

@implementation StartInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	NSInteger testLimit = 80;
	
	WKPickerItem *pickerItemArray[testLimit];
	
	for (NSInteger i = 0; i<testLimit; i++) {
		pickerItemArray[i] = [WKPickerItem alloc];
		[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"Test %ld", (long) i]];
	};
	
	NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: testLimit];
	
	[_testNumPicker setItems:pickerItem];
	
	// Assign pointer to app delegate
	
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

- (IBAction)testPickerAction:(NSInteger)index{
	_appDelegate.userChoice.testNumChosen = index; 
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier{
	
//	NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"NSObject"]];
//	if ([segueIdentifier isEqualToString:@"start"]) {
//		_appDelegate.userChoice.timer = [NSTimer scheduledTimerWithTimeInterval:_appDelegate.userChoice.timeSecond invocation:invocation repeats:NO];
//	}
	return nil;
}

@end




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
@property NSMutableArray* prepArray;
- (IBAction)testNumPickerAction:(NSInteger)index;

@end

@implementation TestPickerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	// Configure testNumPicker;
    _prepArray = nil;
    if (context != nil) {
        _prepArray = context;
        WKPickerItem *pickerItemArray[_prepArray.count];
        for (NSInteger i = 0; i<_prepArray.count; i++) {
            pickerItemArray[i] = [WKPickerItem alloc];
            NSNumber* n = _prepArray[i];
            if (n.integerValue == 0) {
                [pickerItemArray[i] setTitle:@"Select prep test"];
            } else {
                [pickerItemArray[i] setTitle:[NSString stringWithFormat:@"Prep %d", n.integerValue]];
            }
        }
        NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: _prepArray.count];
        
        [_testNumPicker setItems:pickerItem];
        
    }else
    {
	NSInteger testLimit = 80;
	WKPickerItem *pickerItemArray[testLimit+1];
	
	for (NSInteger i = 0; i<testLimit+1; i++) {
        
		pickerItemArray[i] = [WKPickerItem alloc];
		if (i == 0) {
			[pickerItemArray[i] setTitle:@"Select prep test"];
		} else {
			[pickerItemArray[i] setTitle:[NSString stringWithFormat:@"Prep %d", i]];
		}
	}
	
	NSArray *pickerItem = [NSArray arrayWithObjects:pickerItemArray count: testLimit];
	
	[_testNumPicker setItems:pickerItem];
    }
	// Assign pointer to the delegate
	
	_appDelegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
    
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
	[_testNumPicker setSelectedItemIndex:_appDelegate.userChoice.testNumChosen];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


#pragma mark picker action

- (void)pickerDidSettle:(WKInterfacePicker *)picker{
	//Porform expensive tasks.
	
	
}

- (IBAction)testNumPickerAction:(NSInteger)index{
    if (_prepArray != nil) {
        NSNumber* n = _prepArray[index];
        _appDelegate.userChoice.testNumChosen = n.integerValue;
        _appDelegate.userChoice.secNumCurrent = 1;
        _appDelegate.userChoice.quesNumCurrent = 1;

    }else{
        _appDelegate.userChoice.testNumChosen = index;
        _appDelegate.userChoice.secNumCurrent = 1;
        _appDelegate.userChoice.quesNumCurrent = 1;
    }
}


@end




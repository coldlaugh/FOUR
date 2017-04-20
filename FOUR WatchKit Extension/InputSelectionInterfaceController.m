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
@property (nonatomic) IBOutlet WKInterfaceButton* selectPrepButton;
@property (nonatomic) IBOutlet WKInterfaceButton* nextSectionButton;
@property (nonatomic) IBOutlet WKInterfaceButton* undoButton;

@end

@implementation InputSelectionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	_delegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	
	if (context != nil) {
		[_selectPrepButton setHidden:NO];
		[_selectPrepButton setTitle:context];
	} else {
		[_selectPrepButton setHidden:YES];
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
@end




//
//  InterfaceController.m
//  FOUR WatchKit Extension
//
//  Created by leyou on 4/15/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "InterfaceController.h"
#import "ExtensionDelegate.h"
#import "AAUserActivity.h"

@interface InterfaceController ()


-(IBAction)saveAction:(id)sender;


@property (nonatomic) float sliderValue;
- (IBAction)sliderAction:(float)value;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
	
	_sliderValue = 0.0;
	
	
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)saveAction:(id)sender{
	NSLog(@"Debugging: slider value = %f",_sliderValue);
	
	ExtensionDelegate* delegate = [WKExtension sharedExtension].delegate;
	NSManagedObjectContext* taskContext = delegate.persistentContainer.viewContext;
	AAUserActivity* activity = [NSEntityDescription insertNewObjectForEntityForName:@"TEST" inManagedObjectContext:taskContext];
	[activity setSliderValue:_sliderValue];
	
	if ([taskContext hasChanges]) {
		NSError* error;
		[taskContext save:&error];
		if(error != nil){
			abort();
		}
	}
	
	NSLog(@"Debugging: Finished Saving");
	
}

- (IBAction)sliderAction:(float)value{
	NSLog(@"Debugging: set slider value = %f",value);
	_sliderValue = value;
}

@end




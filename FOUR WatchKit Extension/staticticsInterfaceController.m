//
//  SaticticsInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "StaticticsInterfaceController.h"

@interface StaicticsInterfaceController ()


@property (weak) IBOutlet WKInterfaceActivityRing* statRing;


@end

@implementation StaicticsInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	// Configure the activity ring
	
	HKActivitySummary* activitySummary = [HKActivitySummary alloc];
	
	[activitySummary setActiveEnergyBurned:[HKQuantity quantityWithUnit:[HKUnit unitFromString:@"J"] doubleValue:10.0]];
	[activitySummary setActiveEnergyBurnedGoal:[HKQuantity quantityWithUnit:[HKUnit unitFromString:@"J"] doubleValue:20.0]];
	
	[_statRing setActivitySummary:activitySummary animated:YES];
	
	
//	activitySummary
//	[_statRing ]
	
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




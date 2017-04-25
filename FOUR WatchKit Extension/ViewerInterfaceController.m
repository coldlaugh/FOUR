//
//  ViewerInterfaceController.m
//  FOUR
//
//  Created by leyou on 4/22/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "ViewerInterfaceController.h"
#import "ExtensionDelegate.h"
#import "Data.h"
#import "tableRow.h"

@interface ViewerInterfaceController ()

@property ExtensionDelegate* delegate;
@property NSArray* result;

@end

@implementation ViewerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
	
	_delegate = (ExtensionDelegate*) [WKExtension sharedExtension].delegate;
	
	NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"ANSWER"];
	NSError* error;
	NSInteger rowCount = 0;
	NSInteger arraySizeLimit = 400;
	NSMutableArray* textArray = [NSMutableArray arrayWithCapacity:arraySizeLimit];
	NSMutableArray* captionArray = [NSMutableArray arrayWithCapacity:arraySizeLimit];
	NSString* textTotal;
    NSPredicate* predicate;
    NSSortDescriptor* questionSort, *dateSort;
    
    questionSort = [NSSortDescriptor sortDescriptorWithKey:@"question" ascending:YES];
    dateSort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    
    
    
    NSInteger questionCount = 0;
    
	for (int prep = 1; prep < 100; prep++) {
		for (int sec = 1; sec < 5; sec++) {
            
            
            for (int q = 1; q < 60; q++) {
                
            }
            
            // fetch results for this prep and section
            predicate = [NSPredicate predicateWithFormat:@"(preptest == %d) && (section == %d)",prep,sec];
            
			[request setPredicate:predicate];
            [request setReturnsDistinctResults:YES];
            
            // sort data
            [request setSortDescriptors:@[questionSort,dateSort]];
            
            //excute fetch request
			_result = [_delegate.persistentContainer.viewContext executeFetchRequest:request error:&error];
            
            // if result is valid
			if (error == nil & _result.count>0) {
				
				textTotal = @"";
                questionCount = 1;
				for (uint i = 0; i<_result.count; i++) {
					Answer* item = _result[i];
                    
                    // test if there is mutiple input answer for one question
                    // put _ for skipped input answer when it is needed
                    while (item.question > questionCount) {
                        textTotal = [NSString stringWithFormat:@"%@_",textTotal];
                        questionCount++;
                    }
                    
                    if (item.question == questionCount) {
                        textTotal = [NSString stringWithFormat:@"%@%c",textTotal,(item.answer+64)];
                        questionCount++;
                    }
					
				}
				
				
				[textArray addObject:textTotal];
				[captionArray addObject: [NSString stringWithFormat: @"P.%d\rS.%d", prep, sec]];
				rowCount ++;
			}
		}
	}
	
	[_viewerTable setNumberOfRows: rowCount withRowType:@"tableRow"];
	for (int i = 0; i<rowCount; i++) {
		tableRow* row = [_viewerTable rowControllerAtIndex:i];
		[row.itemLabel setText:textArray[i]];
		[row.itemCaption setText:captionArray[i]];
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




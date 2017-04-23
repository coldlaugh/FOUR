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
	
	for (int prep = 1; prep < 10; prep++) {
		for (int sec = 1; sec < 5; sec++) {
//			NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(preptest == %@) && (section == %@)",prep,sec];
//			[request setPredicate:predicate];
			_result = [_delegate.persistentContainer.viewContext executeFetchRequest:request error:&error];
			if (error == nil & _result.count>0) {
				
				textTotal = @"";
				for (uint i = 0; i<_result.count; i++) {
					Answer* item = _result[i];
					textTotal = [NSString stringWithFormat:@"%@%c",textTotal,(item.answer+64)];
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
//		free((__bridge void *)(textArray[rowCount]));
//		free((__bridge void *)(captionArray[rowCount]));
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




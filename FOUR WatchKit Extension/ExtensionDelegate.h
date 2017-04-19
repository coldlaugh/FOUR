//
//  ExtensionDelegate.h
//  FOUR WatchKit Extension
//
//  Created by leyou on 4/15/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <CoreData/CoreData.h>

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>

@property (strong, readonly) NSPersistentContainer *persistentContainer;

-(IBAction)saveAction:(id)sender;

@end

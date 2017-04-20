//
//  ExtensionDelegate.h
//  FOUR WatchKit Extension
//
//  Created by leyou on 4/15/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <CoreData/CoreData.h>
#import "UserChoiceController.h"

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>

@property (strong, readonly) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) UserChoiceController* userChoice;

@end

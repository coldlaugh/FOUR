//
//  Answer.h
//  FOUR
//
//  Created by leyou on 4/22/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Answer : NSManagedObject

@property int16_t answer;
@property int16_t preptest;
@property int16_t question;
@property int16_t section;
@property NSDate* time;

@end

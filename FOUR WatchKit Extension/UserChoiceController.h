//
//  userChoiceStorage.h
//  FOUR
//
//  Created by leyou on 4/19/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserChoiceController : NSObject

@property (nonatomic) NSTimer* timer;
@property (nonatomic) BOOL isTimerEnabled;
@property (nonatomic) NSInteger testNumChosen;
@property (nonatomic) BOOL isTrueAnswerInput;

@end

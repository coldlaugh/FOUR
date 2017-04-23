//
//  tableRow.h
//  FOUR
//
//  Created by leyou on 4/23/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface tableRow : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel* itemLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel* itemCaption;

@end

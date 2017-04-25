//
//  showAnswerInterfaceController.m
//  FOUR
//
//  Created by Leyou Zhang on 4/25/17.
//  Copyright © 2017 leyou. All rights reserved.
//

#import "showAnswerInterfaceController.h"

@interface showAnswerInterfaceController ()

@end

@implementation showAnswerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    if (context != nil) {
        int answer = [(NSNumber*)context integerValue];
        switch (answer) {
            case 1:
                [self.answerLabel setText:@"A"];
                break;
            case 2:
                [self.answerLabel setText:@"B"];
                break;
            case 3:
                [self.answerLabel setText:@"C"];
                break;
            case 4:
                [self.answerLabel setText:@"D"];
                break;
            case 5:
                [self.answerLabel setText:@"E"];
                break;
                
            default:
                [self.answerLabel setText:@"^?^"];
                break;
        }
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




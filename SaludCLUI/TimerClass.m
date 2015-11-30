//
//  TimerClass.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/26/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import "TimerClass.h"
#import "MessageController.h"

#define maxIdleTimeSecs 60.0

@implementation TimerClass

- (void)sendEvent:(UIEvent *)event {
    if (event.type == UIEventTypeTouches) {
        id<TimerClassDelegate> delegate = (id<TimerClassDelegate>)self.delegate;
        [delegate application:self willSendTouchEvent:event];
    }
    [super sendEvent:event];
}
/*
- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    // Only want to reset the timer on a Began touch or an Ended touch, to reduce the number of timer resets.
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        // allTouches count only ever seems to be 1, so anyObject works here.
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan || phase == UITouchPhaseEnded)
            [self resetIdleTimer];
    }
}
*/


@end

//
//  TimerClass.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/26/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerClass : UIApplication
{
NSTimer *idleTimer;
}
@end

@protocol TimerClassDelegate <UIApplicationDelegate>
//- (void)resetIdleTimer;
- (void)application:(TimerClass *)application willSendTouchEvent:(UIEvent *)event;
@end


//
//  ErrorMessageController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/14/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "MessageController.h"
@import UIKit.UIAlertView;

@implementation MessageController


-(void)displayMessage:(NSString *)msg {

UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
message:[NSString stringWithFormat:@"%@",msg] delegate:self
cancelButtonTitle:@"OK" otherButtonTitles:nil];

[alert show];
}

@end

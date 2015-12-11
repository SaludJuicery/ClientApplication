//
//  MenuViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageController.h"

@interface MenuViewController : UIViewController 
{
    MessageController *msg;
}

@property (weak, nonatomic) NSString  *loc;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;

@end

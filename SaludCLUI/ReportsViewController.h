//
//  ReportsViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/6/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface ReportsViewController : UIViewController
{
    MessageController *msg;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reportButton;
@property (strong,nonatomic) DownPicker *downPickerlocation;
@property (strong,nonatomic) DownPicker *downPickerreport;
@property (weak, nonatomic) IBOutlet UITextField *locOption;
@property (weak, nonatomic) IBOutlet UITextField *reportOption;

@end

//
//  UpdateMenuViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageController.h"
#import "DownPicker.h"

@interface UpdateMenuViewController : UIViewController
{
    MessageController *msg;
}

@property (strong,nonatomic) DownPicker *downPickerLoc;

@property (weak, nonatomic) IBOutlet UITextField *itemCat;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *petitePrice;
@property (weak, nonatomic) IBOutlet UITextField *regularPrice;
@property (weak, nonatomic) IBOutlet UITextField *growlerPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemIngre;
@property (weak, nonatomic) IBOutlet UITextField *itemLoc;
@property (weak, nonatomic) IBOutlet UIButton *update;
@property (weak, nonatomic) IBOutlet UIButton *clear;

@property (weak,nonatomic) NSString *tempName;
@property (weak,nonatomic) NSString *tempCat;

- (IBAction)UpdateMenu:(id)sender;
- (IBAction)Clear:(id)sender;

@end

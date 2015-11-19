//
//  CreateMenuController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface CreateMenuController : UIViewController
{
    MessageController *msg;
}

- (IBAction)submitButton:(id)sender;
- (IBAction)clearButton:(id)sender;
- (IBAction)newCategoryBtn:(id)sender;
- (IBAction)addonBtn:(id)sender;

@property(strong,nonatomic) NSMutableArray *categoryList;

@property (strong,nonatomic) DownPicker *downPickerLoc;
@property (strong,nonatomic) DownPicker *downPickerCat;

@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UIButton *addonBtn;

@property (weak, nonatomic) IBOutlet UITextField *itemCat;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *growler;
@property (weak, nonatomic) IBOutlet UITextField *petite;
@property (weak, nonatomic) IBOutlet UITextField *regular;
@property (weak, nonatomic) IBOutlet UITextField *location;

@property (weak, nonatomic) IBOutlet UITextView *itemDesc;

@end

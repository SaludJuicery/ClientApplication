//
//  RewardsViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/28/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"


@interface RewardsViewController : UIViewController <UITextFieldDelegate>
{
    MessageController *msg;
}

@property (strong,nonatomic) DownPicker *downPickerCat;
@property (strong,nonatomic) DownPicker *downPickerItem;
@property (strong,nonatomic) DownPicker *downPickerLoc;
@property (weak, nonatomic) IBOutlet UITextField *txtFldCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtFldItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;
@property (weak, nonatomic) IBOutlet UITextField *txtFldAmount;
@property (weak, nonatomic) IBOutlet UITextField *txtFldStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFldEndDate;

@property (weak, nonatomic) IBOutlet UIButton *btnRadioPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnRadioPercent;
@property (weak, nonatomic) IBOutlet UIButton *btnStartCheckbox;
@property (weak, nonatomic) IBOutlet UIButton *btnEndCheckbox;

-(IBAction)onRadioBtn:(id)sender;
-(IBAction)onCheckBoxBtn:(id)sender;

- (IBAction)addReward:(id)sender;
- (IBAction)clearFields:(id)sender;

-(void)getMenuItems:(id)sender;

@end

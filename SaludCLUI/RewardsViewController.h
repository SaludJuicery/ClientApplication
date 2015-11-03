//
//  RewardsViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/28/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"



@interface RewardsViewController : UIViewController <UITextFieldDelegate>


@property (strong,nonatomic) DownPicker *downPickerCat;
@property (strong,nonatomic) DownPicker *downPickerItem;
@property (strong,nonatomic) DownPicker *downPickerLoc;
@property (weak, nonatomic) IBOutlet UITextField *textCategory;
@property (weak, nonatomic) IBOutlet UITextField *textLocation;
@property (weak, nonatomic) IBOutlet UITextField *textItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rewardsButton;
@property (weak, nonatomic) IBOutlet UITextField *textAmount;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@property (weak, nonatomic) IBOutlet UIButton *radioPrice;
@property (weak, nonatomic) IBOutlet UIButton *radioPercent;

-(IBAction)onRadioBtn:(id)sender;

- (IBAction)addReward:(id)sender;
- (IBAction)clearFields:(id)sender;

@end

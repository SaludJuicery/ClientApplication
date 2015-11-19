//
//  ShopHoursViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/7/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageController.h"
#import "DownPicker.h"

@interface ShopHoursViewController : UIViewController {
    UIView *footerView;
    MessageController *msg;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hoursButton;

@property (strong,nonatomic) DownPicker *downPickerLoc;
@property (strong,nonatomic) DownPicker *downPickerDay;
@property (strong,nonatomic) DownPicker *downPickerStatus;

@property (weak, nonatomic) IBOutlet UITextField *textStatus;
@property (weak, nonatomic) IBOutlet UITextField *textLoc;
@property (weak, nonatomic) IBOutlet UITextField *textDay;
@property (weak, nonatomic) IBOutlet UITextField *textOpen;
@property (weak, nonatomic) IBOutlet UITextField *textClose;


@property (weak,nonatomic) NSArray *jsonArray;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
- (IBAction)clearFields:(id)sender;

- (IBAction)updateHours:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *clear;

@end

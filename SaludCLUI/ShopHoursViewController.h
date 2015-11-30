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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;

@property (strong,nonatomic) DownPicker *downPickerLoc;
@property (strong,nonatomic) DownPicker *downPickerDay;
@property (strong,nonatomic) DownPicker *downPickerStatus;

@property (weak, nonatomic) IBOutlet UITextField *txtFldStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLoc;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDay;
@property (weak, nonatomic) IBOutlet UITextField *txtFldOpenTime;
@property (weak, nonatomic) IBOutlet UITextField *txtFldCloseTime;


@property (weak,nonatomic) NSArray *jsonArray;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
- (IBAction)updateHours:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClear;

- (IBAction)clearFields:(id)sender;

@end

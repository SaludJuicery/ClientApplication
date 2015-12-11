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

@property (weak, nonatomic) IBOutlet UITextField *txtFldCategory1;
@property (weak, nonatomic) IBOutlet UITextField *txtFldItem;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPetite;
@property (weak, nonatomic) IBOutlet UITextField *txtFldRegular;
@property (weak, nonatomic) IBOutlet UITextField *txtFldGrowler;
@property (weak, nonatomic) IBOutlet UITextView *txtViewIngre;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;

@property (nonatomic,strong) NSString *tempName;
@property (nonatomic,strong) NSString *tempCategory;

- (IBAction)UpdateMenu:(id)sender;
- (IBAction)Clear:(id)sender;

@end

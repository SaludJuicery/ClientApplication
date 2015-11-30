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

@interface CreateMenuController : UIViewController <UITextViewDelegate>
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

@property (weak, nonatomic) IBOutlet UIButton *btnNewCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateItem;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UIButton *btnAddon;

@property (weak, nonatomic) IBOutlet UITextField *txtFldCat;
@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldGrowler;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPetite;
@property (weak, nonatomic) IBOutlet UITextField *txtFldRegular;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLocation;

@property (weak, nonatomic) IBOutlet UITextView *txtViewDesc;

@end

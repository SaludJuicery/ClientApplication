//
//  CreateMenuController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateMenuController : UIViewController

- (IBAction)submitButton:(id)sender;
- (IBAction)clearButton:(id)sender;
//- (void)displayMessage:(NSString *)msg;

@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UITextField *itemCat;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;
@property (weak, nonatomic) IBOutlet UITextView *itemIngre;
@property(weak,nonatomic) NSString *tempCat;

@end

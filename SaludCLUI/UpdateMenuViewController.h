//
//  UpdateMenuViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMenuViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *itemCat;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (weak, nonatomic) IBOutlet UITextField *itemPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;
@property (weak, nonatomic) IBOutlet UITextView *itemIngre;
@property (weak, nonatomic) IBOutlet UIButton *update;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak,nonatomic) NSString *tempName;

- (IBAction)UpdateMenu:(id)sender;
- (IBAction)Clear:(id)sender;

@end

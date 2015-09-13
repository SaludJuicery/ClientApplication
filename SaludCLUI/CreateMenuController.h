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

@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UIButton *clear;

@end

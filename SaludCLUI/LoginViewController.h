//
//  ViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/19/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDKeychainBindings.h"
#import "MessageController.h"

@interface LoginViewController : UIViewController {
    BOOL checked;
    IBOutlet UIButton *btnCheckBox;
    PDKeychainBindings *bindings;
    MessageController *msg;
}
- (IBAction)checkBoxButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFldUsername;

@end


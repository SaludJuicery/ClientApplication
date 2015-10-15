//
//  ViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/19/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDKeychainBindings.h"

@interface LoginViewController : UIViewController {
    BOOL checked;
    IBOutlet UIButton *checkBoxButton;
    PDKeychainBindings *bindings;
}
- (IBAction)checkBoxButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *userLogin;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *username;

@end


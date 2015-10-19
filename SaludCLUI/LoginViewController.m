//
//  ViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/19/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "LoginViewController.h"
#import "PDKeychainBindings.h"
#import "RemoteLogin.h"
#import "MessageController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)checkBoxButton:(id)sender {
    if (checked) {
        checked = NO;
        [checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    } else {
        checked = YES;
        [checkBoxButton setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        
        //To store username and password when RememberMe box is clicked.
        bindings = [PDKeychainBindings sharedKeychainBindings];
        [bindings setObject:_username.text  forKey:@"username"];
        [bindings setObject:_password.text forKey:@"password"];
        
    }
}

- (IBAction)userLogin:(UIButton *)sender {
    
    MessageController *msg=[[MessageController alloc] init];
    
    //If Username field is empty
    if([_username isEqual:@""])
    {
        [msg displayMessage:@"Input Error: Username is empty"];
        [_username becomeFirstResponder];
    }
    //IF password field is empty
    else if([_password isEqual:@""])
    {
        [msg displayMessage:@"Input Error: Password is empty"];
        [_password becomeFirstResponder];
    }
    //Below code let user navigate to MenuView Controller upon successfull login
    else
    {
        int res;
        //retrieve username and password
        NSString *username = _username.text;
        NSString *password = _password.text;
        
        NSArray *keys = [NSArray arrayWithObjects:@"password", @"username", nil];
        NSArray *objects = [NSArray arrayWithObjects:password,username, nil];

        
        NSString *url = @"http://ec2-52-88-11-130.us-west-2.compute.amazonaws.com:3000/auth/login";

        RemoteLogin *remote = [[RemoteLogin alloc] init];
        res = [remote getConnection:keys forobjects:objects forurl:url];
        
        /*if(res==1)
        {
            [msg displayMessage:@"Login Error: Invalid Credentials"];
            [_username becomeFirstResponder];
        }
        else
        {
            //This code will help to navigate from Login Screen to  MenuViewController
           */ [self performSegueWithIdentifier:@"MenuViewSegue" sender: self];
        //}
       
    }
}


- (void)viewDidLoad {
    checked= FALSE;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//This method is used to clear all the fileds and reset checkbox in login screen
-(void)viewWillAppear:(BOOL)animated
{
  _username.text=@"";
    _password.text=@"";
 [checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_username becomeFirstResponder];
    [super viewWillAppear:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

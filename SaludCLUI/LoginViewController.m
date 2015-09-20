//
//  ViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/19/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "LoginViewController.h"
#import "PDKeychainBindings.h"

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
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:_username.text options:0 range:NSMakeRange(0, [_username.text length])];
    
    //If Username field is empty
    if([_username isEqual:@""])
    {
        [self displayErrorMsg:@"Login Failed: Username is empty"];
        [_username becomeFirstResponder];
    }
    //IF the email address provided is not Valid display alert box
    else if(!match)
    {
        [self displayErrorMsg:@"Login Failed: Invalid Email Format. Ex:abc@xyz.com"];
        [_username becomeFirstResponder];
        
    }
    //Below code validates given username with database records and if not match show error message
    else if([_username.text isEqualToString:@"Vivek@gmail.com"]==NO)
    {
        [self displayErrorMsg:@"Login Failed: Invalid Username"];
        [_username becomeFirstResponder];
        
    }
    //IF password field is empty
    else if([_password isEqual:@""])
    {
        [self displayErrorMsg:@"Login Failed: Password is empty"];
        [_password becomeFirstResponder];
    }
    //Below code validates given password with database records and if not match then show error messages
    else if([_password.text isEqualToString:@"Vivek"]==NO)
    {
        [self displayErrorMsg:@"Login Failed: Invalid Password"];
        [_password becomeFirstResponder];
        
    }
    //Below code let user navigate to MenuView Controller upon successfull login
    else
    {
        //How to retrieve username and password
        //NSString *username = [bindings objectForKey:@"username"];
        //NSString *password = [bindings objectForKey:@"password"];

        //Display the Username and Password
       // NSLog(@"Username: %@, Password: %@",username,password);
        
        //This code will help to navigate from Login Screen to MenuViewController
      [self performSegueWithIdentifier:@"MenuViewSegue" sender: self];
    }
}

-(void)displayErrorMsg:(NSString *)errMsg{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Message"
                          message:[NSString stringWithFormat:@"%@",errMsg]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
    
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

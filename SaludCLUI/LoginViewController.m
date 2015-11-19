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
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "Reachability.h"

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

    msg = [[MessageController alloc] init];
    
//If Username field is empty
if([_username.text isEqualToString:@""])
{
[msg displayMessage:@"Input Error: Username is empty"];
[_username becomeFirstResponder];
}
//IF password field is empty
else if([_password.text isEqualToString:@""])
{
[_username resignFirstResponder];
[msg displayMessage:@"Input Error: Password is empty"];
[_password becomeFirstResponder];
}
//Below code let user navigate to MenuView Controller upon successfull login
else
{
[_password resignFirstResponder];

int res;

//retrieve username and password
NSString *username =@"salud.partner@gmail.com";//_username.text;
NSString *password = @"Partner@Salud";//_password.text;

NSArray *keys = [NSArray arrayWithObjects:@"password", @"username", nil];
NSArray *objects = [NSArray arrayWithObjects:password,username, nil];

GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:0];

    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No Internet Connection available..Please try again later."];
    } else {
    
RemoteLogin *remote = [[RemoteLogin alloc] init];
res = [remote getConnection:keys forobjects:objects forurl:url];

/*if(res==1)
{
    if([remote.errorMsg containsString:@"not connect"])
    {
        [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
    }
    else
    {
    [msg displayMessage:@"Login Error: Invalid Credentials"];
    }
}
else if(res==2)
{
*///This code will help to navigate from Login Screen to  MenuViewController
[self performSegueWithIdentifier:@"MenuViewSegue" sender: self];
/*}
else
{}
*/
        }
    }
}


- (void)viewDidLoad {
checked= FALSE;
[super viewDidLoad];

    
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

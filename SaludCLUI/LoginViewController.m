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
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {

    [super viewDidLoad];
    checked= FALSE;
    
    _txtFldUsername.borderStyle = UITextBorderStyleRoundedRect;
    _txtFldPassword.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)checkBoxButton:(id)sender {
if (checked) {
checked = NO;
[btnCheckBox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
} else {
checked = YES;
[btnCheckBox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];

//To store username and password when RememberMe box is clicked.
bindings = [PDKeychainBindings sharedKeychainBindings];
[bindings setObject:_txtFldUsername.text  forKey:@"username"];
[bindings setObject:_txtFldPassword.text forKey:@"password"];

}
}

- (BOOL) validateEmail:(NSString*) emailString {
    
    if([emailString length]==0){
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];

    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}


- (IBAction)userLogin:(UIButton *)sender {

    msg = [[MessageController alloc] init];
    
//If Username field is empty
if([_txtFldUsername.text isEqualToString:@""])
{
[msg displayMessage:@"Input Error: Username is empty"];
}
//IF password field is empty
else if([_txtFldPassword.text isEqualToString:@""])
{
[msg displayMessage:@"Input Error: Password is empty"];
}
//Below code let user navigate to MenuView Controller upon successfull login
else if(![self validateEmail:_txtFldUsername.text])
{
[msg displayMessage:@"Invalid username. Ex:xyz@gmail.com"];
}
else
{

NSString *username =@"salud.partner@gmail.com";//_txtFldUsername.text;
NSString *password = @"Partner@Salud";//_txtFldPassword.text;

NSArray *keys = [NSArray arrayWithObjects:@"password", @"username", nil];
NSArray *objects = [NSArray arrayWithObjects:password,username, nil];

GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:0];

    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No Internet Connection available..Please try again later."];
    }
    else
    {
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];

        if(res==1)
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else if(res==2)
        {
                [self performSegueWithIdentifier:@"MenuViewSegue" sender: self];
        }
        else
        {
            [msg displayMessage:@"Login Credentials are invalid."];
        }
    }
}
}


//This method is used to clear all the fileds and reset checkbox in login screen
-(void)viewWillAppear:(BOOL)animated
{
_txtFldUsername.text=@"";
_txtFldPassword.text=@"";
[btnCheckBox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];

[super viewWillAppear:true];
}
- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

@end

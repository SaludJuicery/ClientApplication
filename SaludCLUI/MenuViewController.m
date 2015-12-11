//
//  MenuViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "RemoteGetData.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "Reachability.h"
#import "AppDelegate.h"

@interface MenuViewController () <UIAlertViewDelegate>
{
    AppDelegate *appDelegate;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
[super viewDidLoad];
    
    
    _btnMenu.target=self.revealViewController;
    _btnMenu.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    // Get the location to display orders
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Select a Location"
                                                     message:[NSString stringWithFormat:@"Please click a location below!!!"] delegate:self
                                           cancelButtonTitle:@"Shadyside" otherButtonTitles:@"Sewickley", nil];
    [alert1 show];
    
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    NSString *value1 = [[NSString alloc] init];
    
    if([title isEqualToString:@"Shadyside"])
    {
        value1 = @"shady";
    }
    else
    {
        value1 = @"sewickley";
    }
    appDelegate.location = value1;
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.

}

@end

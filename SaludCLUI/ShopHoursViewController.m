//
//  ShopHoursViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/7/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "ShopHoursViewController.h"
#import "SWRevealViewController.h"
#import "MessageController.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "Reachability.h"

@interface ShopHoursViewController ()

@end

@implementation ShopHoursViewController
@synthesize txtFldStatus,txtFldCloseTime,txtFldOpenTime;

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.
    int i;
    for(i=1;i<=5;i++)
    {
        UITextField *textField=(UITextField *)[self.view viewWithTag:i];
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
_btnMenu.target=self.revealViewController;
_btnMenu.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // create the array of data for location and bind to location field
    NSMutableArray* locArray = [[NSMutableArray alloc] init];
    [locArray addObject:@"Shadyside"];
    [locArray addObject:@"Sewickly"];
    [locArray addObject:@"Both Location"];
    self.downPickerLoc= [[DownPicker alloc] initWithTextField:self.txtFldLoc withData:locArray];
   
    // create the array of data for day and bind to location field
    NSMutableArray* dayArray = [[NSMutableArray alloc] init];
    [dayArray addObject:@"Monday"];
    [dayArray addObject:@"Tuesday"];
    [dayArray addObject:@"Wednesday"];
    [dayArray addObject:@"Thursday"];
    [dayArray addObject:@"Friday"];
    [dayArray addObject:@"Saturday"];
    [dayArray addObject:@"Sunday"];

    self.downPickerDay= [[DownPicker alloc] initWithTextField:self.txtFldDay withData:dayArray];
    
    // Bind the open or close status to the deropdown of each day
    NSMutableArray* open_close = [[NSMutableArray alloc] init];
    [open_close addObject:@"open"];
    [open_close addObject:@"close"];
    self.downPickerStatus= [[DownPicker alloc] initWithTextField:self.txtFldStatus withData:open_close];
    
    //This function will get open and close time based on location selected
   // [self.downPickerLoc addTarget:self action:@selector(getLoc:) forControlEvents:UIControlEventValueChanged];
    
    [self.downPickerDay addTarget:self
                           action:@selector(getLoc:)
                 forControlEvents:UIControlEventValueChanged];
    
}


-(void)getLoc:(id)sender
{
    
    NSString *locName = [self.downPickerLoc text];
    NSString *dayName = [self.downPickerDay text];
 
    msg = [[MessageController alloc] init];
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:12];
    
    int res1;
    
    if(![locName isEqualToString:@""])
    {
        
        NSArray *keys = [NSArray arrayWithObjects:@"location",@"day", nil];
        NSArray *objects = [NSArray arrayWithObjects:locName,dayName, nil];
        
        RemoteGetData *remote = [[RemoteGetData alloc] init];
        
        //Below code checks whether internet connection is there or not
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        msg = [[MessageController alloc] init];
        
        if (networkStatus == NotReachable) {
            [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
        }
        else
        {
            res1 = [remote getJsonData:keys forobjects:objects forurl:url];
            
            if(res1 == 1)
            {
                if([remote.errorMsg containsString:@"not connect"])
                {
                    [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
                }
                else
                {
                    [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
                }
            }
            else if(res1 == 2)
            {
                //Receive the timings as dict and store in array
                NSMutableArray *hoursArray = remote.jsonData;
                
                NSDictionary *itemDict = [hoursArray objectAtIndex:0];
                
                txtFldOpenTime.text = [itemDict objectForKey:@"open_time"];
                txtFldCloseTime.text = [itemDict objectForKey:@"close_time"];
                txtFldStatus.text = ([[itemDict objectForKey:@"is_open"] isEqualToString:@"open"])?@"open":@"close";

            }
        }
    }
    else
    {
        [msg displayMessage:@"Please select a location.."];
    }
}


- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

- (BOOL)validateString:(NSString *)string
{
    //Other Time validation regex
    //(1[01]|[1-9]):[0-5][0-9](\\s)?(?i)(am|pm)
    // \\d{2}:\\d{2}(am|pm)
    // (0|1)[0-9]:[0-5][0-9](am|pm)
    // (0[1-9]|1[0-9]|2[])(:[0-5][0-9])(am|pm)
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"([01]?[0-9]|2[0-3]):[0-5][0-9]" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regExp firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if(!match)
        return NO;
    else
        return YES;
    
}

- (IBAction)updateHours:(id)sender{
    
    msg = [[MessageController alloc] init];
    NSString *loc = [self.downPickerLoc text];
    NSString *day = [self.downPickerDay text];
    NSString *status = [self.downPickerStatus text];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"hh:mma";
    NSDate *openTime= [dateFormatter dateFromString:txtFldOpenTime.text];
    NSDate *closeTime = [dateFormatter dateFromString:txtFldCloseTime.text];
    NSComparisonResult compareTimeResult = [openTime compare:closeTime];

    
    if ([loc isEqualToString:@""])
    {
        [msg displayMessage:@"Please select a location..."];
    }
    else if ([day isEqualToString:@""])
    {
        [msg displayMessage:@"Please select a day..."];
    }
    else if (![self validateString:txtFldOpenTime.text])
    {
        [msg displayMessage:@"Please enter a valid shop open time...hh:mm am|pm"];
    }
    else if (![self validateString:txtFldCloseTime.text])
    {
        [msg displayMessage:@"Please enter a valid shop open time...hh:mm am|pm"];
    }
    else if(compareTimeResult == NSOrderedDescending)
    {
        [msg displayMessage:@"Open Time should be less than Close Time"];
    }
    else if(compareTimeResult == NSOrderedSame)
    {
        [msg displayMessage:@"Open and Close Time cannot be same"];
    }
    else if ([status isEqualToString:@""])
    {
        [msg displayMessage:@"Please select a status..."];
    }
    else {
        
        NSArray *keys = [NSArray arrayWithObjects:@"day",@"location",@"open_time",@"close_time",@"is_open", nil];
        NSArray *objects = [NSArray arrayWithObjects:[self.downPickerDay text],[self.downPickerLoc text],txtFldOpenTime.text,txtFldCloseTime.text,[self.downPickerStatus text], nil];
        
        
        GetUrl *href = [[GetUrl alloc] init];
        NSString *url = [href getHref:11];
        
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        
        //Below code checks whether internet connection is there or not
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        msg = [[MessageController alloc] init];
        
        if (networkStatus == NotReachable) {
            [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
        }
        else
        {
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            if([remote.errorMsg containsString:@"not connect"])
            {
                [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
            }
            else
            {
                [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
            }
        }
        else
        {
            [msg displayMessage:@"Shop Timings have been updated Successfully."];
        }
        }
    }
}

- (IBAction)clearFields:(id)sender {
    int i;
    
    for(i=0;i<5;i++)
    {
        UITextField *txtFldField=(UITextField *)[self.view viewWithTag:i];
        [txtFldField setText:@""];
    
    }
}
@end

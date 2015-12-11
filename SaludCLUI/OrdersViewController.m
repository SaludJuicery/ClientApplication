//
//  OrdersViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/10/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "OrdersViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "RemoteLogin.h"
#import "Reachability.h"
#import "sjOrderTableViewCell.h"
#import "MenuViewController.h"
#import <MessageUI/MessageUI.h>

@interface OrdersViewController () <MFMailComposeViewControllerDelegate>
{
    NSArray *subOrderArray;
    NSMutableDictionary *emailDict;
    NSMutableArray *titleArray;
    NSDictionary *jsonDict;
    NSMutableArray  *orderArray;
    NSInteger sectionCount;
    NSString *setLocation;
    AppDelegate *appDelegate;

}
@end


@implementation OrdersViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
_btnMenu.target=self.revealViewController;
_btnMenu.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _tblViewOrders.delegate = self;
    _tblViewOrders.dataSource=self;
    [self.view addSubview:_tblViewOrders];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    setLocation = appDelegate.location;
    
    

    //Display the orders
    [self getOrders:nil];
    
    //Start the polling request
    [self startPoll:setLocation];
        
    
}

- (void) startPoll:(NSString *)getLocation {
    //[self performSelectorInBackground:@selector(longPoll:) withObject:getLocation];

    [self performSelectorOnMainThread:@selector(getOrders:)
                           withObject:getLocation waitUntilDone:YES];
    
    //send the next poll request after every 30 secs
    [self performSelector:@selector(startPoll:) withObject:getLocation afterDelay:60];
}

-(void)getOrders:(NSString *)getLocation
{
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    
    titleArray = [[NSMutableArray alloc]init];
    orderArray = [[NSMutableArray alloc]init];
    emailDict = [[NSMutableDictionary alloc]init];
        
    GetUrl *url = [[GetUrl alloc] init];
    NSString *reqURL = [url getHref:15];
    
    RemoteGetData *remote = [[RemoteGetData alloc] init];
    
    NSArray *keys = [NSArray arrayWithObjects:@"location", nil];
    NSArray *objects = [NSArray arrayWithObjects:setLocation, nil];
    
    int res = [remote getJsonData:keys forobjects:objects forurl:reqURL];
    
    if(res==1)
    {
        if([remote.errorMsg containsString:@"not connect"])
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else
        {
            [msg displayMessage:@"Error Occured. Please try again later."];
        }
    }
    else
    {
       // here i am getting 101 error
      if(remote.jsonData.count > 0)
       {
       
        NSMutableArray *sortedOrderArray = [self sortArrayBasedOndatetime:remote.jsonData];
        
        
        for(int i=0;i<sortedOrderArray.count;i++)
        {
            
            NSDictionary *itemDict = [sortedOrderArray objectAtIndex:i];
            
            NSString *setOrderID = [NSString stringWithFormat:@"%@", [itemDict objectForKey:@"orderid"]];
            
            NSString *orderID =[setOrderID stringByAppendingString:@", "];

            NSString *date = [itemDict objectForKey:@"date"];
            
            date = [date stringByAppendingString:@", "];
            
            NSString *time =[itemDict objectForKey:@"time"];
            
            NSString *sectionTitle =[orderID stringByAppendingString:[date stringByAppendingString:time]];
            
            // Store date & time as string in an array
            [titleArray addObject:sectionTitle];
            
            //This will store all the email to send order status
            NSString *key = [itemDict objectForKey:@"orderid"];
            NSString *value = [itemDict objectForKey:@"email"];
            emailDict[key]=value;
            
            // This will have sorted dict of orders
            [orderArray addObject:itemDict];
            
        }// End of For
        
        // Contains the number of orders count to create section
        sectionCount = [orderArray count];
         
        }// End of inner if
       else
       {
           [msg displayMessage:@"No Orders available currently."];
       }
     }
    }
}

/*
 Sort the array based on date and time
*/
-(NSMutableArray *)sortArrayBasedOndatetime:(NSMutableArray *)arraytoSort
{
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"yyyy-MM-dd"];
    
    NSComparator compareDates = ^(id string1, id string2)
    {
        NSDate *date1 = [fmtDate dateFromString:string1];
        NSDate *date2 = [fmtDate dateFromString:string2];
        
        return [date1 compare:date2];
    };
    
    NSSortDescriptor * sortDesc1 = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES comparator:compareDates];
    
    NSDateFormatter *fmtTime = [[NSDateFormatter alloc] init];
    [fmtTime setDateFormat:@"HH:mm"];
    
    NSComparator compareTimes = ^(id string1, id string2)
    {
        NSDate *time1 = [fmtTime dateFromString:string1];
        NSDate *time2 = [fmtTime dateFromString:string2];
        
        return [time1 compare:time2];
    };
   
    NSSortDescriptor * sortDesc2 = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES comparator:compareTimes];
    
    [arraytoSort sortUsingDescriptors:@[sortDesc1, sortDesc2]];
    
    return arraytoSort;
}

#pragma mark UITableViewDataSource methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    sjOrderTableViewCell *cell = nil;
    
    NSArray *orderDateTime = [[titleArray objectAtIndex:section] componentsSeparatedByString:@","];
    
    static NSString *AutoCompleteRowIdentifier = @"TitleCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    
    cell.lblOrderTitle.text = [@"Order ID: " stringByAppendingString:[orderDateTime[0] stringByAppendingString:[@", Date:" stringByAppendingString:[orderDateTime[1] stringByAppendingString:[@", Time :" stringByAppendingString:orderDateTime[2]]]]]];
    
    int orderID = [orderDateTime[0] intValue];

    [cell.btnComplete setTag:orderID];
    [cell.btnFailue setTag:orderID];
    
    [cell.btnComplete addTarget:self action:@selector(orderComplete:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnFailue addTarget:self action:@selector(orderFailed:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell.contentView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
    NSString *temp = [[orderArray objectAtIndex:section] objectForKey:@"order"];
    
    return [[temp componentsSeparatedByString:@";"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *orderDetails = [[[[orderArray objectAtIndex:indexPath.section] objectForKey:@"order"] componentsSeparatedByString:@";"] objectAtIndex:indexPath.row];
    
    orderDetails = [orderDetails stringByReplacingOccurrencesOfString:@"[" withString:@""];
    orderDetails = [orderDetails stringByReplacingOccurrencesOfString:@"]" withString:@""];
    
    sjOrderTableViewCell *cell = nil;
    
    static NSString *AutoCompleteRowIdentifier = @"OrderCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    
    NSArray *subOrder = [orderDetails componentsSeparatedByString:@","];
  
    cell.lblOrder.text = subOrder[1];
    
    cell.lblQty.text = subOrder[2];
    
    cell.lblSize.text = subOrder[3];
    
    cell.lblNotes.text =[@"Notes: " stringByAppendingString:subOrder[4]];
    
    NSString *temp= [subOrder[5] stringByReplacingOccurrencesOfString:@"|" withString:@","];
    
    cell.lblAddOn.text = [@"Add-Ons: " stringByAppendingString:temp];


    return cell;
}

-(void) orderComplete:(id)sender{

    UIButton *button = (UIButton *)sender;

    NSString *order_id = [NSString stringWithFormat:@"%d",button.tag];
    
    NSArray *keys = [NSArray arrayWithObjects:@"orderid", nil];
    
    NSArray *objects = [NSArray arrayWithObjects:order_id, nil];
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:16];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection avialable..Please connect to the internet.."];
    }
    else
    {
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            if([remote.errorMsg containsString:@"not connect"])
            {
                [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
            }
            else
            {
                [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
            }
        }
        else
        {
            [msg displayMessage:@"Order Served"];
            
            // Gets the updated order
            [self getOrders:setLocation];
            [self.tblViewOrders reloadData];
            
            // Send notification to customer indicating order cancelled
            //[self customerNotification:order_id msg:@"Your Order has been completed. Please visit the shop to collect the items."];
        }
    }
}

-(void)orderFailed:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    NSString *order_id = [NSString stringWithFormat:@"%d",button.tag];
    
    NSArray *keys = [NSArray arrayWithObjects:@"order_to_cancel", nil];
    
    NSArray *objects = [NSArray arrayWithObjects:order_id, nil];
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:18];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection avialable..Please connect to the internet.."];
    }
    else
    {
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            if([remote.errorMsg containsString:@"not connect"])
            {
                [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
            }
            else
            {
                [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
            }
        }
        else
        {
            [msg displayMessage:@"Order Cancelled"];
            
            // Gets the updated order
            [self getOrders:setLocation];
            [self.tblViewOrders reloadData];
            
            // Send notification to customer indicating order cancelled
           // [self customerNotification:order_id msg:@"Your Order has been cancelled as we ran shortage of the items which you have placed."];
        }
    }
}

-(void) customerNotification:(NSString *)indx msg:(NSString *)statusMsg
{
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection..Please connect to the internet.."];
    }
    else
    {
        NSString *mailMsgBody = [@"Dear Customer," stringByAppendingString:statusMsg];
        
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:@"Order Confirmation"];
            [mail setMessageBody:mailMsgBody isHTML:NO];
            [mail setToRecipients:[emailDict objectForKey:indx]];
            
            [self presentViewController:mail animated:YES completion:NULL];
        }
        else
        {
            [msg displayMessage:@"The device cannot send mail from the device."];
        }
    }
}



#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //differ between your sections or if you
    //have only on section return a static value
    return 44;
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
@end

//
//  HoursTableViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/13/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "HoursTableViewController.h"
#import "MessageController.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "ShopHoursViewController.h"
#import "RemoteGetData.h"
#import "Reachability.h"
@interface HoursTableViewController ()

@end

@implementation HoursTableViewController
@synthesize mClose,mOpen,tOpen,tClose,wClose,wOpen,tuClose,tuOpen,fClose,fOpen,satClose,satOpen,sunClose,sunOpen,mstatus,tustatus,wstatus,tstatus,fstatus,satstatus,sunstatus;

- (void)viewDidLoad {
[super viewDidLoad];

// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"Shadyside"];
[arrLoc addObject:@"Sewickly"];
[arrLoc addObject:@"Both Location"];
self.downPickerloc= [[DownPicker alloc] initWithTextField:self.txtFldLoc withData:arrLoc];

// Bind the open or close status to the deropdown of each day
NSMutableArray* open_close = [[NSMutableArray alloc] init];
[open_close addObject:@"open"];
[open_close addObject:@"close"];
self.downPickermon= [[DownPicker alloc] initWithTextField:self.mstatus withData:open_close];
self.downPickertue= [[DownPicker alloc] initWithTextField:self.tustatus withData:open_close];
self.downPickerwed= [[DownPicker alloc] initWithTextField:self.wstatus withData:open_close];
self.downPickerthu= [[DownPicker alloc] initWithTextField:self.tstatus withData:open_close];
self.downPickerfri= [[DownPicker alloc] initWithTextField:self.fstatus withData:open_close];
self.downPickersat= [[DownPicker alloc] initWithTextField:self.satstatus withData:open_close];
self.downPickersun= [[DownPicker alloc] initWithTextField:self.sunstatus withData:open_close];

//This function will get open and close time based on location selected
[self.downPickerloc addTarget:self
               action:@selector(getLoc:)
     forControlEvents:UIControlEventValueChanged];
// Uncomment the following line to preserve selection between presentations.
// self.clearsSelectionOnViewWillAppear = NO;

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)getLoc:(id)sender
{
_locName = [self.downPickerloc text];

NSMutableArray* timeArray = [[NSMutableArray alloc] init];
    msg = [[MessageController alloc] init];
GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:12];
int res1;
NSArray *keys = [NSArray arrayWithObjects:@"location", nil];
NSArray *objects = [NSArray arrayWithObjects:_locName, nil];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"Could not establish connection to server..No internet connection..Please try again.."];
    }
    else
    {
    
RemoteGetData *remote = [[RemoteGetData alloc] init];
res1 = [remote getJsonData:keys forobjects:objects forurl:url];

if(res1 == 1)
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
else if(res1 == 2)
{
//Receive the menu items as array
NSMutableArray *menuArray = remote.jsonData;

//Loop the items got from the backend and store in this array
for (int i=0;i<menuArray.count;i++) {

NSDictionary *itemDict = [menuArray objectAtIndex:i];

[timeArray addObject:[itemDict objectForKey:@"open_time"]];
[timeArray addObject:[itemDict objectForKey:@"close_time"]];
[timeArray addObject:[itemDict objectForKey:@"is_open"]];
}
}


mOpen.text = timeArray[0];
mClose.text = timeArray[1];
mstatus.text = timeArray[2];

tuOpen.text = timeArray[3];
tuClose.text = timeArray[4];
tustatus.text = timeArray[5];

wOpen.text = timeArray[6];
wClose.text = timeArray[7];
wstatus.text=timeArray[8];

tOpen.text = timeArray[9];
tClose.text = timeArray[10];
tstatus.text=timeArray[11];

fOpen.text = timeArray[12];
fClose.text = timeArray[13];
fstatus.text=timeArray[14];

satOpen.text = timeArray[15];
satClose.text = timeArray[16];
satstatus.text=timeArray[17];

sunOpen.text = timeArray[18];
sunClose.text = timeArray[19];
sunstatus.text=timeArray[20];
    }
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

// Return the number of sections.
return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

if(section==0)
return 1;
else
return 10;
}


#pragma mark UITableViewDelegate methods

/*

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
// Return NO if you do not want the specified item to be editable.
return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
if (editingStyle == UITableViewCellEditingStyleDelete) {
// Delete the row from the data source
[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
} else if (editingStyle == UITableViewCellEditingStyleInsert) {
// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
}   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
// Return NO if you do not want the item to be re-orderable.
return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

//^(?:0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$
//^([1-9]|1[0-9]|2[0-3]):[0-5][0-9][am|pm]$
//Regex to validate the time in each textfield
- (BOOL)validateString:(NSString *)string
{
NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"(1[012]|[1-9]):[0-5][0-9](\\s)?(?i)(am|pm)" options:NSRegularExpressionCaseInsensitive error:NULL];
NSTextCheckingResult *match = [regExp firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];

if(!match)
return NO;
else
return YES;

}

//MEthod to send the time to DB for updating hours

- (IBAction)updateHours:(id)sender {
    msg = [[MessageController alloc] init];
    
if (![self validateString:mOpen.text])
{
    [msg displayMessage:@"Monday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:mClose.text])
{
   [msg displayMessage:@"Monday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:tuOpen.text])
{
    [msg displayMessage:@"Tuesday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:tuClose.text])
{
    [msg displayMessage:@"Tuesday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:wOpen.text])
{
    [msg displayMessage:@"Wednesday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:wClose.text])
{
    [msg displayMessage:@"Wednesday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:tOpen.text])
{
   [msg displayMessage:@"Thursday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:tClose.text])
{
    [msg displayMessage:@"Thursday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:fOpen.text])
{
    [msg displayMessage:@"Friday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:fClose.text])
{
   [msg displayMessage:@"Friday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:satOpen.text])
{
    [msg displayMessage:@"Saturday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:satClose.text])
{
    [msg displayMessage:@"Saturday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:sunOpen.text])
{
    [msg displayMessage:@"Sunday Open: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else if (![self validateString:sunClose.text])
{
    [msg displayMessage:@"Sunday Close: Enter valid Time. hh:mmam|pm or h:mm am|pm"];
}
else
{

   /*Get all the day open and close time and status, and store in a string object*/
    
//NSString *mon =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Monday",@"opening_time",mOpen.text,@"closing_time",mClose.text,@"location",[self.downPickerloc text],@"is_open",mstatus.text];

    NSString *mon =[NSString stringWithFormat:@"%@,%@", mOpen.text,mClose.text];
    NSString *tue =[NSString stringWithFormat:@"%@,%@", tuOpen.text,tuClose.text];
    NSString *wed =[NSString stringWithFormat:@"%@,%@", wOpen.text,wClose.text];
    NSString *thu =[NSString stringWithFormat:@"%@,%@", tOpen.text,tClose.text];
    NSString *fri =[NSString stringWithFormat:@"%@,%@", fOpen.text,fClose.text];
    NSString *sat =[NSString stringWithFormat:@"%@,%@", satOpen.text,satClose.text];
    NSString *sun =[NSString stringWithFormat:@"%@,%@", sunOpen.text,sunClose.text];
/*
NSString *tue =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Tuesday",@"opening_time",tuOpen.text,@"closing_time",tuClose.text,@"location",[self.downPickerloc text],@"is_open",tustatus.text];

NSString *wed =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Wedneday",@"opening_time",wOpen.text,@"closing_time",wClose.text,@"location",[self.downPickerloc text],@"is_open",wstatus.text];
   
NSString *thu =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Thursday",@"opening_time",tOpen.text,@"closing_time",tClose.text,@"location",[self.downPickerloc text],@"is_open",tstatus.text];

NSString *fri =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Friday",@"opening_time",fOpen.text,@"closing_time",fClose.text,@"location",[self.downPickerloc text],@"is_open",fstatus.text];

NSString *sat =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Saturday",@"opening_time",satOpen.text,@"closing_time",satClose.text,@"location",[self.downPickerloc text],@"is_open",satstatus.text];

NSString *sun =[NSString stringWithFormat:@"'%@':'%@','%@':'%@','%@':'%@','%@':'%@','%@':'%@'",@"day",@"Sunday",@"opening_time",sunOpen.text,@"closing_time",sunClose.text,@"location",[self.downPickerloc text],@"is_open",sunstatus.text];
*/
 //Create a string object for all days
NSString *result = [NSString stringWithFormat:@"%@;%@;%@;%@;%@;%@;%@;%@",mon,tue,wed,thu,fri,sat,sun,[self.downPickerloc text]];

    NSLog(@"Result:%@",result);
/*NSMutableArray *timings = [[NSMutableArray alloc] init];

//[timings addObject:result];
    [timings addObject:mon];
    [timings addObject:tue];
    [timings addObject:wed];
    [timings addObject:thu];
    [timings addObject:fri];
    [timings addObject:sat];
    [timings addObject:sun];
    
    NSLog(@"Timings:%@",timings);*/

NSArray *keys = [NSArray arrayWithObjects:@"timings",@"location", nil];
NSArray *objects = [NSArray arrayWithObjects:result,[self.downPickerloc text], nil];


GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:11];

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
[msg displayMessage:@"Shop Timings have been updated Successfully"];
}
}
}
@end

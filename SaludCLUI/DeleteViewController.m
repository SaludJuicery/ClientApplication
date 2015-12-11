//
//  DeleteViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "DeleteViewController.h"
#import "MessageController.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "GetCategories.h"
#import "GetMenuItems.h"
#import "Reachability.h"
#import "AppDelegate.h"

@interface DeleteViewController ()
//Only required when using built-in delete button for tableview
//@property (strong, nonatomic) NSIndexPath *indexPathToBeDeleted;
{
    AppDelegate *appDelegate;
    NSString *openTime;
    NSString *closeTime;
    NSString *currentTime;
    int createFlag;

}
@end

@implementation DeleteViewController
@synthesize autoCompleteData;
@synthesize tblViewItems;
@synthesize selectedObjects;


- (void)viewDidLoad {
[super viewDidLoad];

    // Get Time
    [self getTime];
    
    //Compare Time
    int flag = [self compareTime];
    
    //if(!flag)
   // {
    
    _txtFldCategory.borderStyle = UITextBorderStyleRoundedRect;
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    //Get the Categories from db
    GetCategories  *getCategory = [[GetCategories alloc] init];
        NSMutableArray *categoryArray = [getCategory getData:3];
    
    self.downPickerCat = [[DownPicker alloc] initWithTextField:self.txtFldCategory withData:categoryArray];
    }
 
tblViewItems.delegate = self;
tblViewItems.dataSource = self;
tblViewItems.scrollEnabled = YES;
[tblViewItems setEditing:YES animated:YES];


/* This line will only show tableview visible cells*/
self.tblViewItems.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//Below line is to show the tblViewItems in the screen
[self.view addSubview:tblViewItems];

[self.downPickerCat addTarget:self
action:@selector(getMenuItems:)
forControlEvents:UIControlEventValueChanged];
        
    //}
}

-(void)getMenuItems:(id)sender {

    GetMenuItems *getMenuItems = [[GetMenuItems alloc] init];
    
    NSMutableArray *getItems = [getMenuItems getMenuItems:[self.downPickerCat text]];
    
    if(getItems.count > 0)
    {
        self.autoCompleteData = getItems;
    }
    else
    {
        [self.autoCompleteData addObject:@"No Data Available"];
    }
    [tblViewItems reloadData];
}


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
return autoCompleteData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell *cell = nil;
static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
if (cell == nil) {
cell = [[UITableViewCell alloc]
initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
}

    cell.textLabel.text = [autoCompleteData objectAtIndex:indexPath.row];
    
return cell;
}


#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//differ between your sections or if you
//have only on section return a static value
return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

if(viewFooter == nil)
{
viewFooter  = [[UIView alloc] init];

UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
[button  setBackgroundColor:[UIColor redColor]];

[button setFrame:CGRectMake(10, 3, 450, 44)];
[button setTitle:@"Delete Selected" forState:UIControlStateNormal];
[button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[button addTarget:self action:@selector(deleteItems:)
forControlEvents:UIControlEventTouchUpInside];

UITableViewCell *cell = nil;
static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
cell = [[UITableViewCell alloc]
initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
cell.textLabel.text = @"";
}
return viewFooter;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
return YES;
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


-(void)getTime
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int res1;
    
    NSString *locName = appDelegate.location;
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:12];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
    
    if([locName containsString:@"shady"])
    {
        locName = @"Shadyside";
    }
    else
    {
        locName = @"Sewickley";
    }
    
    NSArray *keys = [NSArray arrayWithObjects:@"location",@"day", nil];
    NSArray *objects = [NSArray arrayWithObjects:locName,dayName, nil];
    
    RemoteGetData *remote = [[RemoteGetData alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
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
            
            openTime = [itemDict objectForKey:@"open_time"];
            closeTime = [itemDict objectForKey:@"close_time"];
        }
    }
}


-(int)compareTime
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *cTime1= [dateFormatter dateFromString:openTime];
    NSDate *cTime2 = [dateFormatter dateFromString:closeTime];
    NSDate *systemTime = [dateFormatter dateFromString:currentTime];
    
    NSComparisonResult openTimeResult = [[dateFormatter stringFromDate:systemTime] compare:[dateFormatter stringFromDate:cTime1]];
    NSComparisonResult closeTimeResult = [[dateFormatter stringFromDate:systemTime] compare:[dateFormatter stringFromDate:cTime2]];
    
    if(openTimeResult == NSOrderedDescending && closeTimeResult == NSOrderedAscending)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}


//Below code is for deleting multiple items at once
- (IBAction)deleteItems:(id)sender {
    
NSArray *selectedCells = [self.tblViewItems indexPathsForSelectedRows];
msg = [[MessageController alloc] init];

if ([_txtFldCategory.text isEqualToString:@""])
{
[msg displayMessage:@"Category Field cannot be empty."];
}
else if(selectedCells.count > 0)
{

UIAlertView *deleteConfirm = [[UIAlertView alloc]
initWithTitle:@"Confirmation"
message:@"Are you sure to delete?"
delegate:self
cancelButtonTitle:@"NO"
otherButtonTitles:@"YES", nil];

[deleteConfirm show];
}
else
{
[msg displayMessage:@"Please select items to delete."];
}
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

if([title isEqualToString:@"YES"])
{
    
msg = [[MessageController alloc]init];

NSArray *selectedCells = [self.tblViewItems indexPathsForSelectedRows];
    
NSMutableIndexSet *indicesToDelete  = [[NSMutableIndexSet alloc] init];

//Store selected Cells value in an array
    
    NSString *itemsToDelete =@"";
    
//Get the indexs from the array to delete items
for (NSIndexPath *indexPath in selectedCells) {
    [indicesToDelete addIndex:indexPath.row];
   
    if(![itemsToDelete isEqualToString:@""])
    {
    itemsToDelete = [itemsToDelete stringByAppendingString:[[autoCompleteData objectAtIndex:indexPath.row] stringByAppendingString:@","]];
    }
    else
    {
        itemsToDelete = [itemsToDelete stringByAppendingString:[autoCompleteData objectAtIndex:indexPath.row]];
    }
}
    
//Below code is for manual Delete Button
[autoCompleteData removeObjectsAtIndexes:indicesToDelete];
[tblViewItems beginUpdates];
[tblViewItems deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
[tblViewItems endUpdates];
[tblViewItems reloadData];

    NSLog(@"Item:%@",itemsToDelete);
    
    
//Generate Objects and Keys to pass to url
NSArray *keys = [NSArray arrayWithObjects:@"category",@"menuItemsToDelete", nil];
NSArray *objects = [NSArray arrayWithObjects:_txtFldCategory.text, itemsToDelete, nil];
    
//Get the Delete url from plist file
GetUrl *href = [[GetUrl alloc] init];
NSString *url = [href getHref:7];

    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection..Please connect to the internet.."];
    }
    else
    {
    
//Make a connection to the given url
RemoteLogin *remote = [[RemoteLogin alloc] init];
int res = [remote getConnection:keys forobjects:objects forurl:url];

//If error display message else show success message
if(res==1)
{
    if([remote.errorMsg containsString:@"not connect"])
    {
        [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
    }
    else
    {
        [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
    }}
else
{
[msg displayMessage:@"Menu Items Deleted Successfully"];
}
}
}
}
@end


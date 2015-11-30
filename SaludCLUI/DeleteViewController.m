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

@interface DeleteViewController ()
//Only required when using built-in delete button for tableview
//@property (strong, nonatomic) NSIndexPath *indexPathToBeDeleted;

@end

@implementation DeleteViewController
@synthesize autoCompleteData;
@synthesize tblViewItems;
@synthesize selectedObjects;


- (void)viewDidLoad {
[super viewDidLoad];

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
    NSMutableArray *categoryArray = [getCategory getCategories];
    
    self.downPickerCat = [[DownPicker alloc] initWithTextField:self.txtFldCategory withData:categoryArray];
    }
 //hide the delete custom button if items generated is fewer
if(self.autoCompleteData.count < 10)
{
[self.btnDelete setHidden:YES];
}
else
{
[self.btnDelete setHidden:NO];

}

/*
* Below code is used to hide the table view once the menu screen loads.
*/
tblViewItems.delegate = self;
tblViewItems.dataSource = self;
tblViewItems.scrollEnabled = YES;
tblViewItems.hidden = NO;
[tblViewItems setEditing:YES animated:YES];


/* This line will only show tableview visible cells*/
self.tblViewItems.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//Below line is to show the tblViewItems in the screen
[self.view addSubview:tblViewItems];

[self.downPickerCat addTarget:self
action:@selector(getMenuItems:)
forControlEvents:UIControlEventValueChanged];

}

-(void)getMenuItems:(id)sender {

    GetMenuItems *getMenuItems = [[GetMenuItems alloc] init];
    
    NSMutableArray *getItems = [getMenuItems getMenuItems:[self.downPickerCat text]];
    
    self.autoCompleteData = getItems;

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

// custom view for footer. will be adjusted to default or specified footer height
// Notice: this will work only for one section within the table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

if(viewFooter == nil) {
//allocate the view if it doesn't exist yet
viewFooter  = [[UIView alloc] init];

//create the button
UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
[button  setBackgroundColor:[UIColor redColor]];

//the button should be as big as a table view cell
[button setFrame:CGRectMake(10, 3, 320, 44)];

//set title, font size and font color
[button setTitle:@"Delete Selected" forState:UIControlStateNormal];
[button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

//set action of the button
[button addTarget:self action:@selector(deleteItems:)
forControlEvents:UIControlEventTouchUpInside];


UITableViewCell *cell = nil;
static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
cell = [[UITableViewCell alloc]
initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
cell.textLabel.text = @"";

//Show button in footer only when 10 or less items are there
if(self.autoCompleteData.count < 10)
{
//add the empty cell and button to the uitableview footer
[viewFooter addSubview:cell];
[viewFooter addSubview:button];
}
}

//return the view for the footer
return viewFooter;
}


/*Below code is used to enable the editing mode in the tableview*/
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
    NSMutableArray *itemsToDelete = [[NSMutableArray alloc] init];
    
//Get the indexs from the array to delete items
for (NSIndexPath *indexPath in selectedCells) {
    [indicesToDelete addIndex:indexPath.row];
    [itemsToDelete addObject:[autoCompleteData objectAtIndex:indexPath.row]];
}
    
//Below code is for manual Delete Button
[autoCompleteData removeObjectsAtIndexes:indicesToDelete];
[tblViewItems beginUpdates];
[tblViewItems deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
[tblViewItems endUpdates];
[tblViewItems reloadData];


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
        [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
    }}
else
{
[msg displayMessage:@"Menu Items Deleted Successfully"];
}
    }
}

}
@end


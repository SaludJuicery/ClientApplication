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
@synthesize autoCompleteView;
@synthesize selectedObjects;


- (void)viewDidLoad {
[super viewDidLoad];

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
    
    self.downPicker = [[DownPicker alloc] initWithTextField:self.textField withData:categoryArray];
    }
 //hide the delete custom button if items generated is fewer
if(self.autoCompleteData.count < 10)
{
[self.deleteBtn setHidden:YES];
}
else
{
[self.deleteBtn setHidden:NO];

}

/*
* Below code is used to hide the table view once the menu screen loads.
*/
autoCompleteView.delegate = self;
autoCompleteView.dataSource = self;
autoCompleteView.scrollEnabled = YES;
autoCompleteView.hidden = NO;
[autoCompleteView setEditing:YES animated:YES];


/* This line will only show tableview visible cells*/
self.autoCompleteView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//Below line is to show the autocompleteview in the screen
[self.view addSubview:autoCompleteView];

[self.downPicker addTarget:self
action:@selector(getMenuItems:)
forControlEvents:UIControlEventValueChanged];

}

-(void)getMenuItems:(id)sender {

    GetMenuItems *getMenuItems = [[GetMenuItems alloc] init];
    
    NSMutableArray *getItems = [getMenuItems getMenuItems:[self.downPicker text]];
    
    self.autoCompleteData = getItems;

    [autoCompleteView reloadData];

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

if(footerView == nil) {
//allocate the view if it doesn't exist yet
footerView  = [[UIView alloc] init];

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
[footerView addSubview:cell];
[footerView addSubview:button];
}
}

//return the view for the footer
return footerView;
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

NSArray *selectedCells = [self.autoCompleteView indexPathsForSelectedRows];
msg = [[MessageController alloc] init];

if ([_textField.text isEqualToString:@""])
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

NSArray *selectedCells = [self.autoCompleteView indexPathsForSelectedRows];
    
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
[autoCompleteView beginUpdates];
[autoCompleteView deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
[autoCompleteView endUpdates];
[autoCompleteView reloadData];


//Generate Objects and Keys to pass to url
NSArray *keys = [NSArray arrayWithObjects:@"category",@"menuItemsToDelete", nil];
NSArray *objects = [NSArray arrayWithObjects:_textField.text, itemsToDelete, nil];
    
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


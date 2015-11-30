//
//  UpdateMenuListController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/18/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuListController.h"
#import "UpdateMenuViewController.h"
#import "MessageController.h"
#import "RemoteGetData.h"
#import "GetUrl.h"
#import "GetCategories.h"
#import "GetMenuItems.h"
#import "Reachability.h"

@interface UpdateMenuListController ()

@end

@implementation UpdateMenuListController
@synthesize itemsArray,tblViewCategories;

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

    //Get the menu categories from db and bind to downpicker textfield
    GetCategories *getCategories = [[GetCategories alloc] init];
    NSMutableArray* categories = [getCategories getCategories];
    self.downPickerCat = [[DownPicker alloc] initWithTextField:self.txtFldCategory withData:categories];
    }
    
    //This function will get open and close time based on location selected
    [self.downPickerCat addTarget:self
                           action:@selector(getMenuItems:)
                 forControlEvents:UIControlEventValueChanged];
    
    //Tableview Delegation and DataSource binding
tblViewCategories.delegate=self;
tblViewCategories.dataSource=self;
    [self.view addSubview:tblViewCategories];

    // This line will only show tableview visible cells
tblViewCategories.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

//Get Menu items from db and bind to downpicker textfield
-(void)getMenuItems:(id)sender {
    
    GetMenuItems *getMenuItems = [[GetMenuItems alloc] init];
    
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {

    NSMutableArray *menuItems = [getMenuItems getMenuItems:[self.downPickerCat text]];
    
    self.itemsArray = menuItems;
        
    [tblViewCategories reloadData];
    }
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {

return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell *cell = nil;
static NSString *CategoryListIdentifier = @"CategoryListIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:CategoryListIdentifier];
if (cell == nil) {
cell = [[UITableViewCell alloc]
initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryListIdentifier];
}

cell.textLabel.text = [itemsArray objectAtIndex:indexPath.row];

return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//Use the below code to pass the selecte tableview cell text to
//Textfield or button or any object
UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

_menuItem =selectedCell.textLabel.text;

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
[button setTitle:@"Continue" forState:UIControlStateNormal];
[button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

//set action of the button
[button addTarget:self action:@selector(showItems:)
forControlEvents:UIControlEventTouchUpInside];

//Add the button to the uitableview footer
[viewFooter addSubview:button];
}

//return the view for the footer
return viewFooter;
}

-(void)showItems:(id) sender {
    
NSArray *selectedCells = [tblViewCategories indexPathsForSelectedRows];
msg = [[MessageController alloc] init];

if([_txtFldCategory.text isEqualToString:@""])
{
[msg displayMessage:@"Category Field cannot be empty."];
}
else if(selectedCells.count < 1)
{
[msg displayMessage:@"Select an item to update."];
}
else
{
[self performSegueWithIdentifier:@"sw_upitem" sender: self];
}
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

UpdateMenuViewController *destViewController = segue.destinationViewController;

destViewController.tempName =_menuItem;
destViewController.tempCat= [self.downPickerCat text];
}


@end

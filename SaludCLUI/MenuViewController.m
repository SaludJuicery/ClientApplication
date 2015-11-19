//
//  MenuViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/20/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "CreateMenuController.h"
#import "RemoteGetData.h"
#import "RemoteLogin.h"
#import "GetUrl.h"
#import "Reachability.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize category = category;
@synthesize pastCategory;
@synthesize autocompleteData;
@synthesize autocompleteTableView;

- (void)viewDidLoad {
[super viewDidLoad];

_barButton.target=self.revealViewController;
_barButton.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    //Get the Categories from db
    [self getCategories:self];
 
  self.autocompleteData = [[NSMutableArray alloc] init];


//Below code is used to hide the table view once the menu screen loads.

autocompleteTableView.delegate = self;
autocompleteTableView.dataSource = self;
autocompleteTableView.scrollEnabled = YES;
autocompleteTableView.hidden = YES;
[self.view addSubview:autocompleteTableView];

//UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(viewLogin)];

//self.navigationItem.leftBarButtonItem = item;
}

-(void)getCategories:(id)sender
{
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:3];
    int res1;
    msg = [[MessageController alloc] init];
    RemoteGetData *remote1 = [[RemoteGetData alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    res1 = [remote1 getJsonData:nil forobjects:nil forurl:url];
    
    if(res1==1)
    {
        if([remote1.errorMsg containsString:@"not connect"])
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else
        {
            [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote1.errorMsg.description]];
        }
    }
    else if(res1==2)
    {
        
        //Receive the json object and add one by one to array
        NSMutableArray *menuCategories = remote1.jsonData;
        
        pastCategory = [[NSMutableArray alloc] init];
        
        for (int i=0;i<menuCategories.count;i++) {
            
            NSDictionary *dict = [menuCategories objectAtIndex:i];
            
            [pastCategory addObject:[dict objectForKey:@"category_name"]];
            
        }//End of For
    }
    }
}

- (IBAction)addNewCategory:(id)sender {

    msg = [[MessageController alloc] init];
    
if ([_nCategory.text isEqualToString:@""])
{

    [msg displayMessage:@"New Category Name cannot be empty"];

}
else
{
// Clean up UI
[category resignFirstResponder];
autocompleteTableView.hidden = YES;

// Add the Category to the list of entered categories as long as it isn't already there
if (![pastCategory containsObject:_nCategory.text]) {
[pastCategory addObject:_nCategory.text];
}
}

}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {

// Put anything that starts with this substring into the autocompleteUrls array
// The items in this array is what will show up in the table view
[autocompleteData removeAllObjects];
for(NSString *curString in pastCategory) {
NSRange substringRange = [curString rangeOfString:substring];
if (substringRange.location == 0) {
[autocompleteData addObject:curString];
}
}
[autocompleteTableView reloadData];
}

- (IBAction)checkContinue:(UIButton *)sender {

    msg = [[MessageController alloc] init];
    
NSString *temp =category.text;

if([temp isEqual:@""])
{
[msg displayMessage:@"Category Name cannot be empty"];
[category becomeFirstResponder];

}
else{
//This code will help to navigate from Menu types to Create Menu Screen
[self performSegueWithIdentifier:@"sw_contmenu" sender: self];
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
/*
CreateMenuController *destViewController = segue.destinationViewController;

if([segue.identifier isEqualToString:@"sw_contmenu"])
{
destViewController.tempCat = category.text;
}
else if ([segue.identifier isEqualToString:@"sw_newmenu"])
{
destViewController.tempCat = _nCategory.text;
}
 */
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
autocompleteTableView.hidden = NO;

NSString *substring = [NSString stringWithString:textField.text];
substring = [substring stringByReplacingCharactersInRange:range withString:string];
[self searchAutocompleteEntriesWithSubstring:substring];
return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
return autocompleteData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell *cell = nil;
static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
if (cell == nil) {
cell = [[UITableViewCell alloc]
initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
}

cell.textLabel.text = [autocompleteData objectAtIndex:indexPath.row];
return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
category.text = selectedCell.textLabel.text;

//  [self goPressed];

}

@end

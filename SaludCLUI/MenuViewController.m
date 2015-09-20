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
   
    /*
     * Now I am going to allocate memory and values to the tableData array 
     * which will be displayed in the UITableView.
     */
    self.pastCategory = [[NSMutableArray alloc] initWithObjects:@"JUICES & REFRESHERS",@"SMOOTHIES",@"HEALTH SHOTS",@"HOT BEVERAGES",@"BOWLS", nil];
    self.autocompleteData = [[NSMutableArray alloc] init];
    
    /*
     * Below code is used to hide the table view once the menu screen loads.
     */
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];

    //UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(viewLogin)];
    
    //self.navigationItem.leftBarButtonItem = item;
}
- (IBAction)addNewCategory:(id)sender {
    
    if ([_nCategory.text isEqualToString:@""])
    {
        
        [self displayErrorMsg:@"New Category Name cannot be empty"];
        [_nCategory becomeFirstResponder];
    
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
    if ([category.text isEqualToString:@""])
    {
        [self displayErrorMsg:@"Category Name cannot be empty"];
        [category becomeFirstResponder];
        
    }
   /* else{
        //This code will help to navigate from Login Screen to MenuViewController
        [self performSegueWithIdentifier:@"sw_contmenu" sender: self];
    }*/
    
    
}

-(void)displayErrorMsg:(NSString *)errMsg{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Message"
                          message:[NSString stringWithFormat:@"%@",errMsg]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
    
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

    
    CreateMenuController *destViewController = segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"sw_continue"]) {
        destViewController.tempCat = category.text;
            }
    else if ([segue.identifier isEqualToString:@"sw_newmenu"]) {
       destViewController.itemCat.text = _nCategory.text;
        
    }
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

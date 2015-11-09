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
    
    // create the array of data
    NSMutableArray* bandArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    //Get URL request as json data and loop by adding data to bandArray
    [bandArray addObject:@"Smoothies"];
    [bandArray addObject:@"Juices & Refereshers"];
    [bandArray addObject:@"Hot Shots"];
    [bandArray addObject:@"Hot Drinks"];
    [bandArray addObject:@"Cleanses"];
    [bandArray addObject:@"Medicinal"];
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:self.textField withData:bandArray];
    
    
    self.autoCompleteData = [[NSMutableArray alloc] initWithObjects:@"JUICES & REFRESHERS",@"SMOOTHIES",@"HEALTH SHOTS",@"HOT BEVERAGES",@"BOWLS", nil];
    
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
    
}



- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autoCompleteData removeAllObjects];
    for(NSString *curString in autoCompleteData) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autoCompleteData addObject:curString];
        }
    }
    [autoCompleteView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    autoCompleteView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
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
    //cell.tintColor=[UIColor redColor];
    cell.textLabel.text = [autoCompleteData objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSString *object = [autoCompleteData objectAtIndex:indexPath.row]; //This assumes that your table has only one section and all cells are populated directly into that section from sourceArray.
    //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // [autoCompleteView deselectRowAtIndexPath:[autoCompleteView indexPathForSelectedRow] animated:NO];
    //UITableViewCell *cell = [autoCompleteView cellForRowAtIndexPath:indexPath];
    /*if (cell.accessoryType == UITableViewCellAccessoryNone) {
     cell.accessoryType = UITableViewCellAccessoryCheckmark;
     [selectedObjects addObject:object];
     } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
     cell.accessoryType = UITableViewCellAccessoryNone;
     [selectedObjects removeObjectIdenticalTo:object];
     }*/
    
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


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Below code is for deleting a row without confirmation
    /*if (editingStyle == UITableViewCellEditingStyleDelete) {
     NSInteger index = indexPath.row;
     [autoCompleteData removeObjectAtIndex:index];
     
     [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
     withRowAnimation:UITableViewRowAnimationFade];
     
     }*/
    
    //Below code is for deleting a row with confirmation
    /*
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     
     // self.indexPathToBeDeleted = indexPath;
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
     message:@"Are you sure?"
     delegate:self
     cancelButtonTitle:@"NO"
     otherButtonTitles:@"YES", nil];
     [alert show];
     
     
     }*/
    
}

/*
 - (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (autoCompleteView.editing)
 {
 return UITableViewCellEditingStyleDelete;
 }
 
 return UITableViewCellEditingStyleNone;
 }
 */
//Below code is for deleting multiple items at once
- (IBAction)deleteItems:(id)sender {
    
    //Below commented code not working
    // MessageController *alertMsg = [[MessageController alloc]init];
    //[alertMsg deleteConfirmation:@"Do you want to delete these items?"];
    
    UIAlertView *deleteConfirm = [[UIAlertView alloc]
                                  initWithTitle:@"Confirmation"
                                  message:@"Are you sure to delete?"
                                  delegate:self
                                  cancelButtonTitle:@"NO"
                                  otherButtonTitles:@"YES", nil];
    
    [deleteConfirm show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"NO"])
    {
        NSLog(@"Nothing to do here");
    }
    else if([title isEqualToString:@"YES"])
    {
        
        NSArray *selectedCells = [self.autoCompleteView indexPathsForSelectedRows];
        NSMutableIndexSet *indicesToDelete  = [[NSMutableIndexSet alloc] init];
        for (NSIndexPath *indexPath in selectedCells) {
            [indicesToDelete addIndex:indexPath.row];
        }
        
        //Below code is for manual Delete Button
        [autoCompleteData removeObjectsAtIndexes:indicesToDelete];
        [autoCompleteView beginUpdates];
        [autoCompleteView deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
        [autoCompleteView endUpdates];
        [autoCompleteView reloadData];
        
        MessageController *msg = [[MessageController alloc]init];
        
        NSArray *keys = [NSArray arrayWithObjects:@"items", nil];
        NSArray *objects = [NSArray arrayWithObjects:autoCompleteData, nil];
        
        NSString *url = @"http://ec2-52-88-11-130.us-west-2.compute.amazonaws.com:3000/menu/reward/insert";
        
        RemoteLogin *remote = [[RemoteLogin alloc] init];
        int res = [remote getConnection:keys forobjects:objects forurl:url];
        
        if(res==1)
        {
            [msg displayMessage:@"Connection Error: Please try again..."];
        }
        else
        {
            [msg displayMessage:@"Menu Items Deleted Successfully"];
        }

        
        
        /* Below code is for built-in delete button
         [autoCompleteData removeObjectAtIndex:[self.indexPathToBeDeleted row]];
         [autoCompleteView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPathToBeDeleted] withRowAnimation:UITableViewRowAnimationFade];
         [autoCompleteView reloadData];*/
    }
    
}
@end


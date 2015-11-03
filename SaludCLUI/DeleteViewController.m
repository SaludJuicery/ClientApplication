//
//  DeleteViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "DeleteViewController.h"
#import "MessageController.h"

@interface DeleteViewController ()

@end

@implementation DeleteViewController
@synthesize autoCompleteData;
@synthesize autoCompleteView;
@synthesize selectedObjects;

- (void)viewDidLoad {
     [super viewDidLoad];
    
    alertMsg = [[MessageController alloc] init];

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

//Below code is for displaying checkmark inside tableviewcell
#pragma mark UITableViewDelegate methods

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return UITableViewCellEditingStyleDelete;
    return 3;
    
}

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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        
        if (indexPath.section == 0){
            [self.autoCompleteView beginUpdates];
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"Category =[cd] %@", @"Category 1"];
            NSArray * catArray = [self.selectedObjects filteredArrayUsingPredicate:pred];
            [self.selectedObjects removeObject:catArray[indexPath.row]];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:NO];
            [self.autoCompleteView endUpdates];
        }
        
    }
}

- (IBAction)deleteItems:(id)sender {
    
   /* NSArray *selectedCells = [self.autoCompleteView indexPathsForSelectedRows];
    NSMutableIndexSet *indicesToDelete = [[NSMutableIndexSet alloc] init];
    for (NSIndexPath *indexPath in selectedCells) {
        [indicesToDelete addIndex:indexPath.row];
    }
    //arrayFromPlist is NSMutableArray
    [autoCompleteView beginUpdates];
    [autoCompleteView deleteRowsAtIndexPaths:selectedCells withRowAnimation:UITableViewRowAnimationAutomatic];
    [autoCompleteView endUpdates];
    [selectedObjects removeObjectsAtIndexes:indicesToDelete];
    [autoCompleteView reloadData];
    */
    [alertMsg deleteConfirmation:@"Do you want to delete these items?"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Code for OK Button
    if (buttonIndex == 0)
    {
        NSLog(@"Ok");
        //NSArray* selectedRows = [autoCompleteView indexPathsForSelectedRows];
        [autoCompleteView deleteRowsAtIndexPaths:selectedObjects
                                withRowAnimation:UITableViewRowAnimationRight];
        [autoCompleteData removeObjectsInArray:selectedObjects];
        [autoCompleteView reloadData];
    }
    
    //Code for Cancel Button
    if (buttonIndex == 1)
    {
         NSLog(@"Cancel");
        
    }
}
@end


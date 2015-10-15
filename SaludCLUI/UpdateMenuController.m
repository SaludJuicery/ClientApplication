//
//  UpdateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuViewController.h"
#import "UpdateMenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "MessageController.h"

@implementation UpdateMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //Show Menu Category Item List
    self.autocompleteData1 = [[NSArray alloc] initWithObjects:@"Smoothies",@"Juices",@"Hot Shots",@"Hot Beverages",@"Add ons", nil];
    _catList.delegate=self;
    _catList.dataSource=self;
    [self.view addSubview:_catList];
    _itemList.hidden=YES;
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
        if([tableView isEqual:_catList])
        {
            return [self.autocompleteData1 count];
        }
        else
        {
            return [self.itemArray count];
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *CategoryListIdentifier = @"CategoryListIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CategoryListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryListIdentifier];
    }
   if([tableView isEqual:_catList])
        cell.textLabel.text = [self.autocompleteData1 objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Use the below code to pass the selecte tableview cell text to
    //Textfield or button or any object
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    if([tableView isEqual:_catList])
    {
        _itemText.text = selectedCell.textLabel.text;
    }
    else
    {
        _TempStr =selectedCell.textLabel.text;
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    UpdateMenuViewController *destViewController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"sw_upmenu"]) {
        destViewController.tempName =_TempStr;
    }
}

- (IBAction)showItems:(id)sender {
   
    //Loop the menu items retrieved from the json file to itemarray using
    //[self.itemArray addObject:@""];
    
    self.itemArray = [[NSArray alloc] initWithObjects:@"Item1",@"Item2",@"Item3",@"Item4",@"Item5", nil];
    
    //Use the below code to pass the data to tableview during runtime
    _itemList.delegate = self;
    _itemList.dataSource = self;
    
    _itemList.scrollEnabled = YES;
    _itemList.hidden = NO;
    
    //Reload the tableview to add updated data
    [self.itemList reloadData];
    
    
}

@end

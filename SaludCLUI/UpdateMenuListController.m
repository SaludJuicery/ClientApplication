//
//  UpdateMenuListController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/18/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuListController.h"
#import "UpdateMenuViewController.h"

@interface UpdateMenuListController ()

@end

@implementation UpdateMenuListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Get the category name and display in the textbox
    _itemText.text = _catName;
    
    
    self.itemArray = [[NSArray alloc] initWithObjects:@"Smoothies",@"Juices",@"Hot Shots",@"Hot Beverages",@"Add ons", nil];
    _itemList.delegate=self;
    _itemList.dataSource=self;
    [self.view addSubview:_itemList];
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
   
       return [self.itemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *CategoryListIdentifier = @"CategoryListIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CategoryListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryListIdentifier];
    }
    
    cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Use the below code to pass the selecte tableview cell text to
    //Textfield or button or any object
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    _menuItem =selectedCell.textLabel.text;
    
}

/*
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
    
    
}*/



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
    
    if ([segue.identifier isEqualToString:@"sw_upitem"]) {
        destViewController.tempName =_menuItem;
    }
}


@end

//
//  NavigationViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/28/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "NavigationViewController.h"
#import "SWRevealViewController.h"
#import "MenuViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController{

NSArray *menu;
}

- (void)viewDidLoad {
[super viewDidLoad];

//Holds the identifier for all tablecell in the Table View
menu=@[@"menu",@"rewards",@"orders",@"hours",@"reports",@"logout"];

// Uncomment the following line to preserve selection between presentations.
self.clearsSelectionOnViewWillAppear = NO;

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

// Return the number of sections.
return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

// Return the number of rows in the section.
return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];

UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

// Configure the cell here if you want

return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.

// Set the title of navigation bar by using the menu items
NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
destViewController.title = [[menu objectAtIndex:indexPath.row] capitalizedString];

}


@end

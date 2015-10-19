//
//  UpdateMenuController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "UpdateMenuListController.h"
#import "UpdateMenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "MessageController.h"

@implementation UpdateMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //Show Menu Category Item List
    self.autocompleteData1 = [[NSArray alloc] initWithObjects:@"Smoothies",@"Juices",@"Hot Shots",@"Hot Beverages",@"Add ons", nil];
    _catList.delegate=self;
    _catList.dataSource=self;
    [self.view addSubview:_catList];
    
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
            return [self.autocompleteData1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *CategoryListIdentifier = @"CategoryListIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CategoryListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryListIdentifier];
    }
   
    cell.textLabel.text = [self.autocompleteData1 objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Use the below code to pass the selecte tableview cell text to
    //Textfield or button or any object
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    _strCat = selectedCell.textLabel.text;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    UpdateMenuListController *destViewController = segue.destinationViewController;
    
    
    if ([segue.identifier isEqualToString:@"sw_uplist"]) {
        destViewController.catName =_strCat;
    }
}

@end

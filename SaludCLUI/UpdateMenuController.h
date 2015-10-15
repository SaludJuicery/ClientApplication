//
//  UpdateMenuController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMenuController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (strong,nonatomic) NSArray *autocompleteData1;
@property (strong,nonatomic) NSArray *itemArray;
@property (weak, nonatomic) IBOutlet UITableView *itemList;
@property (weak, nonatomic) IBOutlet UITableView *catList;
@property (weak, nonatomic) NSString *TempStr;
@property (weak, nonatomic) IBOutlet UIButton *showItems;

- (IBAction)showItems:(id)sender;


@end

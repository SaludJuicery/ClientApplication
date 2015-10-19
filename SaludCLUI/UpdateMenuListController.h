//
//  UpdateMenuListController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/18/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMenuListController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemText;
@property (weak, nonatomic) IBOutlet UITableView *itemList;
@property (strong,nonatomic) NSArray *itemArray;
@property (weak, nonatomic) NSString *menuItem;
@property (weak, nonatomic) NSString *catName;
@property (weak, nonatomic) IBOutlet UIButton *contUpdate;


@end

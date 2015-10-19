//
//  UpdateMenuController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 10/4/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateMenuController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *autocompleteData1;
@property (weak, nonatomic) IBOutlet UITableView *catList;
@property (weak, nonatomic) NSString *strCat;
@property (weak, nonatomic) IBOutlet UIButton *showItems;

@end

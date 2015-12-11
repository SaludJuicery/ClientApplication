//
//  ReportsViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/6/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"


@interface ReportsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    MessageController *msg;
}

@property (weak, nonatomic) IBOutlet UITableView *containerview;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;
@property (strong,nonatomic) DownPicker *downPickerlocation;
@property (weak, nonatomic) IBOutlet UITextField *txtFldlocation;

@property (weak, nonatomic) IBOutlet UILabel *lblnetSales;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactions;
@property (weak, nonatomic) IBOutlet UILabel *lblAvgSales;
@property (weak, nonatomic) IBOutlet UILabel *lblTopItems;

@end

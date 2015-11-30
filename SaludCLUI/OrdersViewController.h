//
//  OrdersViewController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/10/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"
#import "MessageController.h"

@interface OrdersViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSInputStream *InputStream;
    NSOutputStream *OutputStream;
    NSMutableData *OutputData;
    MessageController *msg;
    NSMutableArray * messages;
}

//- (void)resetIdleTimer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnMenu;
@property (weak, nonatomic) IBOutlet UITableView *tblViewOrders;



@end

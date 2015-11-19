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

@interface OrdersViewController : UIViewController
{
    MessageController *msg;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *ordersButton;
@property (weak, nonatomic) IBOutlet UITableView *pendingOrdersList;



@end

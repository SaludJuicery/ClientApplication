//
//  OrdersViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/10/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "OrdersViewController.h"
#import "SWRevealViewController.h"
#import "SIOSocket.h"

@interface OrdersViewController ()
@property SIOSocket *socket;
@property BOOL socketIsConnected;
@end

@implementation OrdersViewController

- (void)viewDidLoad {
[super viewDidLoad];

_ordersButton.target=self.revealViewController;
_ordersButton.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    /*[SIOSocket socketWithHost: @"http://localhost:8000" response: ^(SIOSocket *socket) {
        self.socket = socket;
    }];*/
    
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

@end

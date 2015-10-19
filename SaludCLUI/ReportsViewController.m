//
//  ReportsViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/6/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "ReportsViewController.h"
#import "SWRevealViewController.h"

@interface ReportsViewController ()

@end

@implementation ReportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _reportButton.target=self.revealViewController;
    _reportButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

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

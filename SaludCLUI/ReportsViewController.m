//
//  ReportsViewController.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/6/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "ReportsViewController.h"
#import "SWRevealViewController.h"
#import "DownPicker.h"

@interface ReportsViewController ()

@end

@implementation ReportsViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.

_reportButton.target=self.revealViewController;
_reportButton.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];


// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"Shadyside"];
[arrLoc addObject:@"Sewickly"];
[arrLoc addObject:@"Both Location"];
self.downPickerlocation= [[DownPicker alloc] initWithTextField:self.locOption withData:arrLoc];

// create the array of data for location and bind to location field
NSMutableArray* arrReport = [[NSMutableArray alloc] init];
[arrReport addObject:@"Daily Sales"];
[arrReport addObject:@"Weekly Sales"];
[arrReport addObject:@"Monthly Sales"];
[arrReport addObject:@"Yearly Sales"];
[arrReport addObject:@"Top 5 users"];
self.downPickerreport= [[DownPicker alloc] initWithTextField:self.reportOption withData:arrReport];


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

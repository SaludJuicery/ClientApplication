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
#import "TableViewCell.h"

@interface ReportsViewController ()
@property(weak,nonatomic) IBOutlet TableViewCell *tableviewcell;
@end

@implementation ReportsViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.

    _txtFldlocation.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:self.containerview];
    
_btnMenu.target=self.revealViewController;
_btnMenu.action=@selector(revealToggle:);
[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];


// create the array of data for location and bind to location field
NSMutableArray* arrLoc = [[NSMutableArray alloc] init];
[arrLoc addObject:@"Shadyside"];
[arrLoc addObject:@"Sewickly"];
[arrLoc addObject:@"Both Location"];
self.downPickerlocation= [[DownPicker alloc] initWithTextField:self.txtFldlocation withData:arrLoc];

}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return section?2:4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil] firstObject];
    }
    [cell configUI:indexPath];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 30);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    label.text = section ? @"Daily Sales":@"Weekly Sales";
    label.textColor = [UIColor colorWithRed:0.257 green:0.650 blue:0.478 alpha:1.000];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
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

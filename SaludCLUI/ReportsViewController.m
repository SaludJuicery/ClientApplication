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
#import "Reachability.h"
#import "RemoteGetData.h"
#import "GetCategories.h"
#import "GetUrl.h"
#import "MessageController.h"
#import "AppDelegate.h"

@interface ReportsViewController ()
@property(weak,nonatomic) NSString *chartValues;
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
    
AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];

//[self showSalesReport:appDelegate.location];
    
TableViewCell *tb = [[TableViewCell alloc] init];
[tb getHourlySales:appDelegate.location];
[tb getWeeklySales:appDelegate.location];
}

 -(void)showSalesReport:(NSString *)location
 {
     //Below code checks whether internet connection is there or not
     Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
     NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
     
     msg = [[MessageController alloc] init];
     
     if (networkStatus == NotReachable) {
         [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
     }
     else
     {
         //Get the Categories from db
         GetUrl  *getUrl = [[GetUrl alloc] init];
         NSString *url = [getUrl getHref:17];
         
         RemoteGetData *remote = [[RemoteGetData alloc] init];
         int res = [remote getJsonData:@[@"location"] forobjects:@[location]  forurl:url];
         
         if(res==1)
         {
             [msg displayMessage:@"No Data Available"];
         }
         else
         {
             NSLog(@"Result:%@",remote.jsonData);
             NSDictionary *itemDict = [remote.jsonData objectAtIndex:0];
             NSLog(@"%@",itemDict);
         }
     }
 }

-(void)showSales
{
    TableViewCell *tb1 = [[TableViewCell alloc] init];
    [tb1 getHourlySales:[self.downPickerlocation text]];
    [tb1 getWeeklySales:[self.downPickerlocation text]];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return section?2:4;
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
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 44);
   
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:30];
    label.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    label.text = section ? @"Weekly Sales":@"Hourly Sales";
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

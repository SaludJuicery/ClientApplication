//
//  TableViewCell.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/29/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import "TableViewCell.h"
#import "Reachability.h"
#import "MessageController.h"
#import "RemoteGetData.h"
#import "GetUrl.h"

@implementation TableViewCell

-(void)getWeeklySales:(NSString *)getLocation
{
    
    salesCount = [[NSMutableArray alloc] init];
    days = [[NSMutableArray alloc] init];

    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    MessageController *msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
        //Get the Categories from db
        GetUrl  *getUrl = [[GetUrl alloc] init];
        NSString *url = [getUrl getHref:14];
        
        RemoteGetData *remote1 = [[RemoteGetData alloc] init];
        int res = [remote1 getJsonData:@[@"location"] forobjects:@[getLocation] forurl:url];
        
        if(res==1)
        {
           [msg displayMessage:@"No Data Available"];
        }
        else
        {
            for(int i=0;i<remote1.jsonData.count;i++)
            {
                NSDictionary *dict = [remote1.jsonData objectAtIndex:i];
                 
                [days addObject:[dict objectForKey:@"DAYNAME(date)"]];
                [salesCount addObject:[dict objectForKey:@"SUM(order_sum)"]];
            }
        }
    }
}


-(void)getHourlySales:(NSString *)getLocation
{

    transSum = [[NSMutableArray alloc] init];
    hours = [[NSMutableArray alloc] init];
    
    //Below code checks whether internet connection is there or not
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
       MessageController *msg = [[MessageController alloc] init];
        
        if (networkStatus == NotReachable) {
            [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
        }
        else
        {
            //Get the Categories from db
            GetUrl  *getUrl = [[GetUrl alloc] init];
            NSString *url = [getUrl getHref:13];
            
            RemoteGetData *remote = [[RemoteGetData alloc] init];
            int res = [remote getJsonData:@[@"location"] forobjects:@[getLocation]  forurl:url];
            
            if(res==1)
            {
                [msg displayMessage:@"No Data Available"];
            }
            else
            {
                for(int i=0;i<remote.jsonData.count;i++)
                {
                    NSDictionary *dict = [remote.jsonData objectAtIndex:i];

                    [transSum addObject:[dict objectForKey:@"SUM(order_sum)"]];
                    [hours addObject:[dict objectForKey:@"hour(date)"]];
                }
            }
        }
}

- (void)configUI:(NSIndexPath *)indexPath
{
    
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 270)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

#pragma mark - @required

- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    if (path.section==1 && path.row==0) {
        return @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    }
    if (path.section==0 && path.row==0) {
        return @[@"7",@"8",@"9",@"10",@"11",@"12",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    }
    
    return nil;
}

- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
 NSArray *ary = @[@"22",@"24",@"25",@"26",@"27"];
NSArray *ary1 = @[@"32",@"34",@"35",@"36",@"42",@"47",@"53"];

    
if (path.section==0 && path.row==0) {
            return @[ary];
}
if (path.section==1 && path.row==0) {
        return @[ary1];
}
    return nil;
}

#pragma mark - @optional

- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}

- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (path.row==0) {
        // Get Maximum from the array
        //NSNumber *max=[ary valueForKeyPath:@"@max.self"];
        return CGRangeMake(60, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    /*
     Highlight the line chart with range in gray color
     
     if (path.row==0) {
        return CGRangeMake(25, 75);
    }
     */
    return CGRangeZero;
}

- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==0;
}

- (void)awakeFromNib {
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  TableViewCell.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/29/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChart.h"

@interface TableViewCell : UITableViewCell <UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
    NSMutableArray *days;
    NSMutableArray *salesCount;
    NSMutableArray *hours;
    NSMutableArray *transSum;
}
- (void)getHourlySales:(NSString *)getLocation;
- (void)getWeeklySales:(NSString*)getLocation;
- (void)configUI:(NSIndexPath *)indexPath;

@end

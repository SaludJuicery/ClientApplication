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
}

- (void)configUI:(NSIndexPath *)indexPath;

@end

//
//  TableViewCell.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/29/15.
//  Copyright © 2015 Vanguards. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

#pragma mark - @required

- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    if (path.row==0 && path.section==0) {
        return @[@"one",@"two",@"three",@"four",@"five"];
    }
    return @[@"one",@"two",@"three",@"four",@"five",@"six",@"seven"];
}

- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
    
    if (path.section==0) {
        switch (path.row) {
            case 0:
                return @[ary];
            case 1:
                return @[ary1];
            case 2:
                return @[ary1,ary2];
            default:
                return @[ary1,ary2,ary3];
        }
    }else{
        if (path.row) {
            return @[ary1,ary2];
        }else{
            return @[ary1];
        }
    }
    
    //    if (path.row==0) {
    //        return @[ary];
    //    }
    //    else if (path.row==1) {
    //        return @[ary1];
    //    }
    //    else if (path.row==2){
    //        return @[ary1,ary2];
    //    }
    //    else{
    //        return @[ary1,ary2,ary3];
    //    }
}
#pragma mark - @optional

- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}

- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (path.row==0) {
        return CGRangeMake(60, 10);
    }
    if (path.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    if (path.row==2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}


- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

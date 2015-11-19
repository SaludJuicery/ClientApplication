//
//  GetMenuItems.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/16/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMenuItems : NSObject

@property(strong,nonatomic) NSMutableArray *menuItems;
@property(strong,nonatomic) NSMutableArray *menuItemDetails;

-(NSMutableArray *) getMenuItems:(NSString *) categoryName;
-(NSMutableArray *) getItemDetails:(NSString *) categoryName forItemName:(NSString *)itemName;


@end

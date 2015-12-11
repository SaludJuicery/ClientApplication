//
//  GetCategories.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/16/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCategories : NSObject

@property(strong,nonatomic)  NSMutableArray *categories;

-(NSMutableArray *)getData:(int) indxUrl;

@end

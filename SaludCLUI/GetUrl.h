//
//  GetUrl.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetUrl : NSObject

@property(weak,nonatomic) NSString *url;

-(NSString *)getHref:(int)urlIndex;

@end

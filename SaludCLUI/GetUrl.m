//
//  GetUrl.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/11/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "GetUrl.h"

@interface GetUrl ()

@end

@implementation GetUrl


-(NSString *)getHref:(int)urlIndex
{
    
    //To get the AWS url from plist file
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSArray *array = [dictionary objectForKey:@"Urls"];
   
    return array[urlIndex];
    }

@end

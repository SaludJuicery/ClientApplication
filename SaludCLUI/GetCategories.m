//
//  GetCategories.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/16/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "GetCategories.h"
#import "GetUrl.h"
#import "RemoteGetData.h"
#import "MessageController.h"
#import "Reachability.h"
@implementation GetCategories

@synthesize categories;

-(NSMutableArray *)getData:(int)indxUrl
{
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:indxUrl];
    
    int res1;
    MessageController *msg = [[MessageController alloc] init];
    RemoteGetData *remote1 = [[RemoteGetData alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    
    res1 = [remote1 getJsonData:nil forobjects:nil forurl:url];
    
    if(res1==1)
    {
        if([remote1.errorMsg containsString:@"not connect"])
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else
        {
            [msg displayMessage:[@"Error Occured: " stringByAppendingString:@"Some Error occured with the application. Please try again..."]];
        }
    }
    else if(res1==2)
    {
        
        //Receive the json object and add one by one to array
        NSMutableArray *dataArray = remote1.jsonData;
        
        categories = [[NSMutableArray alloc] init];
        
        for (int i=0;i<dataArray.count;i++) {
            
            NSDictionary *dict = [dataArray objectAtIndex:i];
            
            [categories addObject:[dict objectForKey:@"category_name"]];
            
        }
    }
    }
    return categories;
}

@end

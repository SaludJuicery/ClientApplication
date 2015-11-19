//
//  GetMenuItems.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/16/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "GetMenuItems.h"
#import "MessageController.h"
#import "RemoteGetData.h"
#import "GetUrl.h"
#import "Reachability.h"

@implementation GetMenuItems
@synthesize menuItems;
@synthesize menuItemDetails;


-(NSMutableArray *)getMenuItems:(NSString *)categoryName {
    
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:5];
    int res1;
    NSArray *keys = [NSArray arrayWithObjects:@"category", nil];
    NSArray *objects = [NSArray arrayWithObjects:categoryName, nil];
    RemoteGetData *remote = [[RemoteGetData alloc] init];
    MessageController *msg = [[MessageController alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    res1 = [remote getJsonData:keys forobjects:objects forurl:url];
    
    if(res1 == 1)
    {
        if([remote.errorMsg containsString:@"not connect"])
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else
        {
            [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
        }
    }
    else if(res1 == 2)
    {
        //Receive the menu items as array
        NSMutableArray *menuArray = remote.jsonData;
        
        //Loop the items got from the backend and store in this array
        menuItems = [[NSMutableArray alloc] init];
        
        for (int i=0;i<menuArray.count;i++) {
            
            NSDictionary *itemDict = [menuArray objectAtIndex:i];
            
            [menuItems addObject:[itemDict objectForKey:@"item_name"]];
        }
    }
    }
    
    return  menuItems;
}


-(NSMutableArray *)getItemDetails:(NSString *)categoryName forItemName:(NSString *)itemName {
    
    
    GetUrl *href = [[GetUrl alloc] init];
    NSString *url = [href getHref:5];
    int res1;
    NSArray *keys = [NSArray arrayWithObjects:@"category", nil];
    NSArray *objects = [NSArray arrayWithObjects:categoryName, nil];
    RemoteGetData *remote = [[RemoteGetData alloc] init];
    MessageController *msg = [[MessageController alloc] init];
    
    //Below code checks whether internet connection is there or not
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    msg = [[MessageController alloc] init];
    
    if (networkStatus == NotReachable) {
        [msg displayMessage:@"No internet connection available..Please connect to the internet.."];
    }
    else
    {
    
    res1 = [remote getJsonData:keys forobjects:objects forurl:url];
    
    if(res1 == 1)
    {
        if([remote.errorMsg containsString:@"not connect"])
        {
            [msg displayMessage:@"Could not establish connection to server.. Please try again later."];
        }
        else
        {
            [msg displayMessage:[@"Error Occured: " stringByAppendingString:remote.errorMsg.description]];
        }
    }
    else if(res1 == 2)
    {
        //Receive the menu items as array
        NSMutableArray *menuArray = remote.jsonData;
        
        NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"%K LIKE %@", @"item_name", itemName];
        NSArray *filteredList = [menuArray filteredArrayUsingPredicate:thePredicate];
        
        NSDictionary *itemDict = [[NSDictionary alloc]init];
        itemDict = [filteredList lastObject];
        
        //Loop the items got from the backend and store in this array
        menuItemDetails = [[NSMutableArray alloc] init];
        
        [menuItemDetails addObject:itemDict];
    }
    }
    return  menuItemDetails;
}
@end

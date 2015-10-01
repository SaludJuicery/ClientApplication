//
//  RemoteLogin.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/30/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "RemoteLogin.h"

@implementation RemoteLogin
-(int) getConnection:(NSString*)username forpass:(NSString*)password forurl:(NSString*) getUrl
{
    NSArray *keys = [NSArray arrayWithObjects:@"password", @"username", nil];
    NSArray *objects = [NSArray arrayWithObjects:password,username, nil];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSData *jsonData ;
    NSString *jsonString;
    if([NSJSONSerialization isValidJSONObject:jsonDictionary])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:nil];
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
//    NSString *requestString = getUrl;
    
    NSURL *url = [NSURL URLWithString:getUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];

    //If login is failed
    if (errorReturned) {
        NSLog(@"Error %@",errorReturned.description);
        return 0;
    }
    //If login is success
    else
    {
        NSError *jsonParsingError = nil;
        NSMutableArray *arrDoctorInfo  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
        
         NSLog(@"Dict %@",arrDoctorInfo);
         return 1;
    }
}
@end

//
//  RemoteLogin.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/30/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "RemoteLogin.h"

@implementation RemoteLogin

-(int) getConnection:(NSArray*)keys forobjects:(NSArray*)values forurl:(NSString*) getUrl
{
NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSLog(@"Dict sent:%@",jsonDictionary);
NSData *jsonData ;
NSString *jsonString;

if([NSJSONSerialization isValidJSONObject:jsonDictionary])
{
jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:0 error:nil];
jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

NSURL *url = [NSURL URLWithString:getUrl];
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
[request setHTTPMethod:@"POST"];
[request setHTTPBody: jsonData];
[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];

NSError *errorReturned = nil;
NSURLResponse *theResponse =[[NSURLResponse alloc]init];
NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
    
if (errorReturned) {
_errorMsg = errorReturned.description;
return 1;
}
else
{
NSError *jsonParsingError = nil;
NSMutableArray *arrDoctorInfo  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];
    
 for(NSString *str in arrDoctorInfo)
{
_errorMsg = [_errorMsg stringByAppendingString:str];
}
return 2;
}
}
@end

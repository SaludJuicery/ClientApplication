//
//  RemoteGetData.m
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/15/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "RemoteGetData.h"

@implementation RemoteGetData

-(int)getJsonData:(NSArray *)keys forobjects:(NSArray *)objects forurl:(NSString *)getUrl
{

NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

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

//If login is failed


if (errorReturned) {
_errorMsg = errorReturned.description;
return 1;
}
else
{
NSError *jsonParsingError = nil;
NSMutableArray *arrDoctorInfo  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&jsonParsingError];

//Storing the json data received from the HTTP request
_jsonData = arrDoctorInfo;

return 2;
}
}



@end

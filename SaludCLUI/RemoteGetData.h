//
//  RemoteGetData.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 11/15/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteGetData : NSObject

-(int) getJsonData:(NSArray*)keys forobjects:(NSArray*)values forurl:(NSString*) getUrl;

@property(strong,nonatomic) NSString *errorMsg;
@property(strong,nonatomic) NSMutableArray *jsonData;

@end

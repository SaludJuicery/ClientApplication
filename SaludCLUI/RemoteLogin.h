//
//  RemoteLogin.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 9/30/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteLogin : NSObject
-(int) getConnection:(NSString*)username forpass:(NSString*)password forurl:(NSString*) getUrl;
@end

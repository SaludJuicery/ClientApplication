//
//  PDKeychainBindings.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/24/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDKeychainBindings : NSObject

+ (instancetype) sharedKeychainBindings;

- (NSString*)  stringForKey:(NSString*)def;

- (void)          setString:(NSString*)s
                     forKey:(NSString*)def;

- (void)          setString:(NSString*)s
                     forKey:(NSString*)def
        accessibleAttribute:(CFTypeRef)aa;


-              objectForKey:(NSString*)def;

- (void)          setObject:(NSString*)x
                     forKey:(NSString*)def;

- (void)          setObject:(NSString*)x
                     forKey:(NSString*)def
        accessibleAttribute:(CFTypeRef)aa;

- (void) removeObjectForKey:(NSString*)def;

@end

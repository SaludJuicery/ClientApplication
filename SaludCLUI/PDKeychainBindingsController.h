//
//  PDKeychainBindingsController.h
//  SaludCLUI
//
//  Created by Vivek Sridhar on 8/24/15.
//  Copyright (c) 2015 Vanguards. All rights reserved.
//

#import "PDKeychainBindings.h"

#import <Foundation/Foundation.h>

@interface PDKeychainBindingsController : NSObject

@property (readonly) PDKeychainBindings* keychainBindings;

+ (instancetype) sharedKeychainBindingsController;

/// KVO-observable accessor property representing the PDKeychainBindings' values.

@property (readonly) id values;

- (void)          setValue:x
                forKeyPath:(NSString*)kp
       accessibleAttribute:(CFTypeRef)aa;

- (BOOL)       storeString:(NSString*)s
                    forKey:(NSString*)k
       accessibleAttribute:(CFTypeRef)aa;

- (BOOL)       storeString:(NSString*)s
                    forKey:(NSString*)k;

- (NSString*) stringForKey:(NSString*)k;

#if !TARGET_OS_IPHONE // The following methods are OSX-only

- (void)                  useDefaultKeychain;
- (BOOL) removeExternalKeychainFileWithError:(NSError**)e;
- (BOOL)     useExternalKeychainFileWithPath:(NSString*)x
                                    password:(NSString*)p
                                       error:(NSError**)e;
#endif



@end

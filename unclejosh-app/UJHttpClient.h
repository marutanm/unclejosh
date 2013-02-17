//
//  UJHttpClient.h
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/14/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "AFHTTPClient.h"
#import <AFJSONRequestOperation.h>

@interface UJHttpClient : AFHTTPClient

+ (UJHttpClient *)sharedClient;
- (id)initWithBaseURL:(NSURL *)url;

+ (BOOL)isValid;

- (void)registerUser:(NSString *)name onSuccess:(void (^)())block;
- (void)newHeroWithName:(NSString *)name;

@end

//
//  UJHttpClient.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/14/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHttpClient.h"

@implementation UJHttpClient

+ (UJHttpClient *)sharedClient
{
    static UJHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    NSURL *baseURL = [NSURL URLWithString:@"http://unclejosh.dev/"];
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:baseURL];
    });

    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}

+ (BOOL)isValid
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"]) {
        return YES;
    } else {
        return NO;
    }
}
@end

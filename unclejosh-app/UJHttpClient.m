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
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
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
    [self setDefaultHeader:@"uid" value:[[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"]];
    return self;
}

+ (BOOL)isValid
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"UUID"]) {
        NIDPRINT(@"YES");
        return YES;
    } else {
        NIDPRINT(@"NO");
        return NO;
    }
}

- (void)newHeroWithName:(NSString *)name
{
    NIDPRINT(@"%@", name);

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:name forKey:@"name"];

    [[[self class] sharedClient] postPath:@"heros" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];
}

@end

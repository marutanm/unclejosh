//
//  UJHomeViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/14/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeViewController.h"

#import "UJHttpClient.h"

@interface UJHomeViewController ()

@end

@implementation UJHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UJHttpClient sharedClient] postPath:@"users"
                               parameters:@{@"name" : @"NEW USER"}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NIDPRINT(@"responseObject: %@", responseObject);
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NIDPRINT(@"Error: %@", error);
                                  }
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

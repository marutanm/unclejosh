//
//  UJLoginViewControllerTest.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/23/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJLoginViewControllerTest.h"

#import "UJLoginViewController.h"

@implementation UJLoginViewControllerTest

- (void)testUJLoginViewController
{
    UJLoginViewController *loginViewController = [[UJLoginViewController alloc] init];

    GHVerifyView(loginViewController.view);
}

@end

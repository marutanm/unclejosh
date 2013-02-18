//
//  UJHomeViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/14/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeViewController.h"

#import "UJHttpClient.h"
#import "UJLoginViewController.h"
#import "UJHeroProfileViewController.h"

@interface UJHomeViewController ()

@property UITextField *textField;
@property UJHeroProfileViewController *profileViewController;

@end

@implementation UJHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 210, 31)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.Placeholder = NSLocalizedString(@"Hero's Name", @"placeholder of input hero name");
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.returnKeyType = UIReturnKeyGo;
        _textField.delegate = self;

        _profileViewController = [[UJHeroProfileViewController alloc] init];
        [self addChildViewController:_profileViewController];
        [_profileViewController didMoveToParentViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = _textField;
    [self.view addSubview:_profileViewController.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (![UJHttpClient isValid]) {
        UJLoginViewController *loginViewController = [[UJLoginViewController alloc] init];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newHero
{
    [[UJHttpClient sharedClient] newHeroWithName:_textField.text onSuccess:^(id JSON) {
        [_profileViewController setHeroInfo:JSON];
    }];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField canResignFirstResponder]) [textField resignFirstResponder];

    [self newHero];

    return YES;
}

@end

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
#import "UJHeroTableViewController.h"

@interface UJHomeViewController ()

@property UITextField *textField;
@property UJHeroProfileViewController *profileViewController;
@property UJHeroTableViewController *tableViewController;
@property UIView *clearView;

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

        _tableViewController = [[UJHeroTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self addChildViewController:_tableViewController];
        [_tableViewController didMoveToParentViewController:self];

        _clearView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _clearView.userInteractionEnabled = YES;
        [_clearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = _textField;
    [self.view addSubview:_profileViewController.view];

    _tableViewController.view.frame = CGRectMake(0, _profileViewController.view.frame.origin.y + _profileViewController.view.frame.size.height + self.navigationController.navigationBar.frame.size.height, 320, 480);
    [self.view addSubview:_tableViewController.view];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden) name:UIKeyboardDidHideNotification object:nil];
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
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:_textField.text forKey:@"name"];

    [[UJHttpClient sharedClient] postPath:@"heros" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        [_profileViewController setHeroInfo:responseObject];
        [_tableViewController addHero:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];
}

- (void)keyboardWasShown;
{
    [self.view addSubview:_clearView];
}

- (void)keyboardWasHidden;
{
    [_clearView removeFromSuperview];
}

- (void)hideKeyboard;
{
    if (_textField.editing) {
        [_textField resignFirstResponder];
    }
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

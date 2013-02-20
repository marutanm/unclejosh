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
#import "UJHeroTableViewController.h"
#import "UJResultTableViewController.h"

@interface UJHomeViewController ()

@property UITextField *textField;
@property UJHomeProfileView *profileView;
@property UJHeroTableViewController *tableViewController;
@property UIView *clearView;

@property NSDictionary *heroInfo;

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

        _profileView = [[UJHomeProfileView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        _profileView.delegate = self;

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
    [self.view addSubview:_profileView];

    _tableViewController.view.frame = CGRectMake(0, _profileView.frame.origin.y + _profileView.frame.size.height + self.navigationController.navigationBar.frame.size.height, 320, 480);
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
        _heroInfo = responseObject;
        [_profileView setHeroInfo:_heroInfo];
        [_tableViewController addHero:_heroInfo];
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
#pragma mark UJHomeProfileViewDelegate
- (void)challengeRanking;
{
    NIDPRINTMETHODNAME();
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:[_heroInfo objectForKey:@"id"] forKey:@"hero_id"];

    [[UJHttpClient sharedClient] postPath:@"rankings" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        NSString *localized = NSLocalizedString(@"win:%@ ranking:%@", @"Result of challenge ranking");
        [_profileView setResult:[NSString stringWithFormat:localized, [responseObject objectForKey:@"initial_win"], [responseObject objectForKey:@"rank"]]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];
}

- (void)showResults;
{
    NIDPRINTMETHODNAME();

    NSString *path = [NSString stringWithFormat:@"heros/%@/challenges", [_heroInfo objectForKey:@"id"]];
    [[UJHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        UJResultTableViewController *resultTableViewController = [[UJResultTableViewController alloc] init];
        resultTableViewController.results = responseObject;
        [self.navigationController pushViewController:resultTableViewController animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
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

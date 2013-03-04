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
#import "UJResultTableViewController.h"
#import "UJHeroTableViewCell.h"

@interface UJHomeViewController ()

@property NSMutableArray *heros;
@property UITableView* tableView;
@property NSInteger selectedRow;

@property UITextField *textField;
@property UJHomeProfileView *profileView;
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

        _profileView = [[UJHomeProfileView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
        _profileView.delegate = self;

        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _profileView.frame.origin.y + _profileView.frame.size.height, 320, [[UIScreen mainScreen] applicationFrame].size.height - (44 + _profileView.frame.size.height))];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        _clearView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _clearView.userInteractionEnabled = YES;
        [_clearView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_tableView registerClass:[UJHeroTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];

    self.navigationItem.titleView = _textField;
    [self.view addSubview:_profileView];

    _heros = (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(NULL, (CFArrayRef)[[NSUserDefaults standardUserDefaults] arrayForKey:@"HEROS"], kCFPropertyListMutableContainers);
    if (!_heros) {
        _heros = [NSMutableArray array];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
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

        [_heros insertObject:[NSMutableDictionary dictionaryWithDictionary:responseObject] atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:_heros forKey:@"HEROS"];
        [_tableView reloadData];
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

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
    NSMutableDictionary *selectedHero = [_heros objectAtIndex:_selectedRow];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:[selectedHero objectForKey:@"id"] forKey:@"hero_id"];

    [[UJHttpClient sharedClient] postPath:@"rankings" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [selectedHero setObject:responseObject forKey:@"result"];
        NIDPRINT(@"%@", selectedHero);
        [_profileView setHeroInfo:selectedHero];
        [[NSUserDefaults standardUserDefaults] setObject:_heros forKey:@"HEROS"];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];
}

- (void)showResults;
{
    UJResultTableViewController *resultTableViewController = [[UJResultTableViewController alloc] init];
    NSMutableDictionary *selectedHero = [_heros objectAtIndex:_selectedRow];
    resultTableViewController.heroId = [selectedHero objectForKey:@"id"];
    resultTableViewController.title = [selectedHero objectForKey:@"name"];
    [self.navigationController pushViewController:resultTableViewController animated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField canResignFirstResponder]) [textField resignFirstResponder];

    [self newHero];

    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _heros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UJHeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.hero = [_heros objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedRow = indexPath.row;

    [_profileView setHeroInfo:[_heros objectAtIndex:indexPath.row]];
}

@end

//
//  UJBattleResultViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/26/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJBattleResultViewController.h"
#import "UJHttpClient.h"

@interface UJBattleResultViewController ()

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSArray *turns;
@property (nonatomic) NSDictionary *challenger;
@property (nonatomic) NSDictionary *master;

@end

@implementation UJBattleResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect tableViewFrame = [[UIScreen mainScreen] bounds];
    tableViewFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
    tableViewFrame.size.height -= self.navigationController.navigationBar.frame.size.height;
    _tableView.frame = tableViewFrame;
    [self.view addSubview:_tableView];

    NSString *path = [NSString stringWithFormat:@"battles/%@", _battleId];
    [[UJHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        _turns = [responseObject objectForKey:@"turns"];
        _challenger = [responseObject objectForKey:@"challenger"];
        _master = [responseObject objectForKey:@"master"];

        [_tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _turns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary *turn = [NSDictionary dictionaryWithDictionary:[_turns objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", [turn objectForKey:@"owner"], [turn objectForKey:@"damage"]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

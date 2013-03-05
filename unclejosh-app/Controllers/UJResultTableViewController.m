//
//  UJResultTableViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/13.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJResultTableViewController.h"
#import "UJBattleResultViewController.h"

#import "UJHttpClient.h"

@interface UJResultTableViewController ()

@property (readonly) NSArray *results;

@end

@implementation UJResultTableViewController

NSInteger resultOnOneRow = 5;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _results = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    NSString *path = [NSString stringWithFormat:@"heros/%@/challenges", _heroId];

    [[UJHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        _results = responseObject;
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    return _results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [[[_results objectAtIndex:indexPath.row] objectForKey:@"master"] objectForKey:@"name"];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UJBattleResultViewController *resultViewController = [[UJBattleResultViewController alloc] init];
    resultViewController.battleId = [[_results objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:resultViewController animated:YES];
}

@end

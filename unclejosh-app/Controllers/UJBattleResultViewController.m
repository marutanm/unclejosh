//
//  UJBattleResultViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/26/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJBattleResultViewController.h"
#import "UJHttpClient.h"
#import "UJBattleResultTableHeader.h"

@interface UJBattleResultViewController ()

@property (nonatomic) UITableView *tableView;

@property (nonatomic) NSArray *turns;
@property (nonatomic) NSDictionary *challenger;
@property (nonatomic) NSDictionary *master;

@property (nonatomic) NSArray *lifesOfTurn;

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

        _lifesOfTurn = [self lifesOfTurn];
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

- (NSArray *)lifesOfTurn
{
    NSDictionary *initialState = @{@"master": [_master objectForKey:@"life"], @"challenger": [_challenger objectForKey:@"life"]};
    NSMutableArray *lifes = [NSMutableArray arrayWithObject:initialState];
    for (NSDictionary *turn in _turns) {
        NSDictionary *last = lifes.lastObject;
        if ([turn[@"owner"] isEqualToString:@"master"]) {
            [lifes addObject:@{
             @"master": [last objectForKey:@"master"],
             @"challenger": @([[last objectForKey:@"challenger"] intValue] - [[turn objectForKey:@"damage"] intValue])
             }];
        } else {
            [lifes addObject:@{
             @"master": @([[last objectForKey:@"master"] intValue] - [[turn objectForKey:@"damage"] intValue]),
             @"challenger": [last objectForKey:@"challenger"]
             }];
        }
    }

    return lifes;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _turns.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary *turn = [NSDictionary dictionaryWithDictionary:[_turns objectAtIndex:indexPath.section]];
    NSString *attackerName;
    if ([turn[@"owner"] isEqualToString:@"master"]) {
        attackerName = [_master objectForKey:@"name"];
    } else {
        attackerName = [_challenger objectForKey:@"name"];
    }
    cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@'s attack, %@ damages!", @"Message of each attack"), attackerName, [turn objectForKey:@"damage"]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.rowHeight * 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UJBattleResultTableHeader *header = [[UJBattleResultTableHeader alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, tableView.rowHeight*0.5)];

    NSMutableDictionary *lifes = [NSMutableDictionary dictionary];
    NSInteger lastIndex = (section == 0) ? 0 : section-1;
    for (NSString* key in @[@"challenger", @"master"]) {
        lifes[key] = [NSMutableDictionary dictionary];
        lifes[key][@"current"] = _lifesOfTurn[section][key];
        lifes[key][@"last"] = _lifesOfTurn[lastIndex][key];
    }
    header.lifes = lifes;

    return header;
}

@end

//
//  UJHeroTableViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/18/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHeroTableViewController.h"

@interface UJHeroTableViewController ()

@property NSMutableArray *heros;

@end

@implementation UJHeroTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    _heros = [[NSUserDefaults standardUserDefaults] mutableArrayValueForKey:@"HEROS"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addHero:(id)hero
{
    NIDPRINT(@"%@", hero);
    [_heros addObject:hero];
    [[NSUserDefaults standardUserDefaults] setObject:_heros forKey:@"HEROS"];

    [self.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = [[_heros objectAtIndex:indexPath.row] objectForKey:@"name"];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

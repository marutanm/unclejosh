//
//  UJResultTableViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/13.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJResultTableViewController.h"

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

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResults:(NSArray *)results
{
    NIDPRINT(@"%d = %d / %d + %d", results.count/resultOnOneRow, results.count, resultOnOneRow, results.count%resultOnOneRow);
    NSMutableArray *copy = [NSMutableArray arrayWithArray:results];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < results.count / resultOnOneRow; i++) {
        [temp addObject:[copy subarrayWithRange:NSMakeRange(0, resultOnOneRow)]];
        [copy removeObjectsInRange:NSMakeRange(0, resultOnOneRow)];
    }
    if (copy.count) {
        [temp addObject:copy];
    }
    _results = [NSArray arrayWithArray:temp];
}

- (NSString *)resultsLabelOf:(NSInteger)index
{
    NIDPRINT(@"%d", index);
    NSMutableString *string = [NSMutableString string];
    if (_results) {
        NIDPRINT(@"%@", _results[index]);
        for (NSDictionary *result in _results[index]) {
            if ([[result objectForKey:@"win"] boolValue]) {
                [string appendString:@"O"];
            } else {
                [string appendString:@"X"];
            }
        }
    }
    return string;
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

    cell.textLabel.text = [self resultsLabelOf:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

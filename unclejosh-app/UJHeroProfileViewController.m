//
//  UJHeroProfileViewController.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/17/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHeroProfileViewController.h"
#import "UJHttpClient.h"

@interface UJHeroProfileViewController ()

@property UILabel *nameLabel;
@property UILabel *lifeLabel;
@property UILabel *strengthLabel;
@property UILabel *agilityLabel;
@property NSString *heroId;

@property UIButton *challengebutton;
@property UILabel *resultLabel;

@end

@implementation UJHeroProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 140, 20)];
        _lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 140, 20)];
        _strengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 40, 140, 20)];
        _agilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 70, 140, 20)];

        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
        _challengebutton.frame = CGRectMake(10, 40, 140, 20);
        _challengebutton.hidden = YES;
        [_challengebutton addTarget:self action:@selector(challengeRanking:) forControlEvents:UIControlEventTouchUpInside];
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 140, 20)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 0, 320, 140);

    [self.view addSubview:_nameLabel];
    [self.view addSubview:_lifeLabel];
    [self.view addSubview:_strengthLabel];
    [self.view addSubview:_agilityLabel];

    [self.view addSubview:_challengebutton];
    [self.view addSubview:_resultLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)challengeRanking:(id)sender
{
    NIDPRINT(@"%@", sender);

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObject:_heroId forKey:@"hero_id"];

    [[UJHttpClient sharedClient] postPath:@"rankings" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NIDPRINT(@"%@", responseObject);
        _resultLabel.text = [NSString stringWithFormat:NSLocalizedString(@"win:%@ ranking:%@", @"Result of challenge ranking"), [responseObject objectForKey:@"initial_win"], [responseObject objectForKey:@"rank"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NIDPRINT(@"%@", error);
    }];
}

- (void)setHeroInfo:(id)info
{
    NIDPRINT(@"%@", info);
    _heroId = [info objectForKey:@"id"];
    _nameLabel.text = [info objectForKey:@"name"];
    _lifeLabel.text = [[info objectForKey:@"life"] stringValue];
    _strengthLabel.text = [[info objectForKey:@"strength"] stringValue];
    _agilityLabel.text = [[info objectForKey:@"agility"] stringValue];

    _challengebutton.hidden = NO;
}

@end

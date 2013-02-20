//
//  UJHomeProfileView.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeProfileView.h"

@interface UJHomeProfileView ()

@property UILabel *nameLabel;
@property UILabel *lifeLabel;
@property UILabel *strengthLabel;
@property UILabel *agilityLabel;
@property NSString *heroId;

@property UIButton *challengebutton;
@property UILabel *resultLabel;
@property UIButton *resultButton;

@end

@implementation UJHomeProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];

        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 140, 20)];
        [self addSubview:_nameLabel];

        _lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 140, 20)];
        [self addSubview:_lifeLabel];

        _strengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 40, 140, 20)];
        [self addSubview:_strengthLabel];

        _agilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 70, 140, 20)];
        [self addSubview:_agilityLabel];

        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
        _challengebutton.frame = CGRectMake(10, 40, 140, 20);
        _challengebutton.hidden = YES;
        [_challengebutton addTarget:_delegate action:@selector(challengeRanking:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_challengebutton];

        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 140, 20)];
        [self addSubview:_resultLabel];

        _resultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resultButton setTitle:NSLocalizedString(@"RESULT", @"Label on show challenge result button") forState:UIControlStateNormal];
        _resultButton.frame = CGRectMake(10, 40, 140, 20);
        _resultButton.hidden = YES;
        [_resultButton addTarget:_delegate action:@selector(showResults) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resultButton];

    }
    return self;
}

- (void)setHeroInfo:(id)info;
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

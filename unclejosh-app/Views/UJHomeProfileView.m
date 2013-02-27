//
//  UJHomeProfileView.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeProfileView.h"
#import "UJParameterView.h"

@interface UJHomeProfileView ()

@property UILabel *nameLabel;
@property UILabel *lifeLabel;
@property UILabel *strengthLabel;
@property UILabel *agilityLabel;

@property UJParameterView *lifeGauge;
@property UJParameterView *strengthGauge;
@property UJParameterView *agilityGauge;

@property UIButton *challengebutton;
@property UIButton *resultButton;

@property UILabel *resultLabel;

@end

@implementation UJHomeProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIColor *zuruiBackColor = RGBCOLOR(0xF8, 0xF8, 0xF8);
        self.backgroundColor = zuruiBackColor;

        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 140, 20)];
        _nameLabel.backgroundColor = zuruiBackColor;
        [self addSubview:_nameLabel];

        _lifeGauge = [[UJParameterView alloc] initWithFrame:CGRectMake(170, 10, 140, 20)];
        _lifeGauge.max = 1000;
        [self addSubview:_lifeGauge];

        _lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 140, 20)];
        _lifeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_lifeLabel];

        _strengthGauge = [[UJParameterView alloc] initWithFrame:CGRectMake(170, 40, 140, 20)];
        [self addSubview:_strengthGauge];

        _strengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 40, 140, 20)];
        _strengthLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_strengthLabel];

        _agilityGauge = [[UJParameterView alloc] initWithFrame:CGRectMake(170, 70, 140, 20)];
        [self addSubview:_agilityGauge];

        _agilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 70, 140, 20)];
        _agilityLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_agilityLabel];

        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
        _challengebutton.frame = CGRectMake(10, 40, 140, 20);
        _challengebutton.hidden = YES;
        [_challengebutton addTarget:_delegate action:@selector(challengeRanking) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_challengebutton];

        _resultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resultButton setTitle:NSLocalizedString(@"RESULT", @"Label on show challenge result button") forState:UIControlStateNormal];
        _resultButton.frame = CGRectMake(10, 40, 140, 20);
        _resultButton.hidden = YES;
        [_resultButton addTarget:_delegate action:@selector(showResults) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resultButton];

        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 140, 20)];
        _resultLabel.backgroundColor = zuruiBackColor;
        [self addSubview:_resultLabel];
    }
    return self;
}

- (void)setHeroInfo:(NSDictionary *)heroInfo;
{
    _nameLabel.text = [heroInfo objectForKey:@"name"];
    _lifeLabel.text = [[heroInfo objectForKey:@"life"] stringValue];
    _strengthLabel.text = [[heroInfo objectForKey:@"strength"] stringValue];
    _agilityLabel.text = [[heroInfo objectForKey:@"agility"] stringValue];

    _lifeGauge.value = [[heroInfo objectForKey:@"life"] intValue];
    _strengthGauge.value = [[heroInfo objectForKey:@"strength"] intValue];
    _agilityGauge.value = [[heroInfo objectForKey:@"agility"] intValue];

    if (heroInfo[@"result"]) {

        NSString *localized = NSLocalizedString(@"win:%@ ranking:%@", @"Result of challenge ranking");
        _resultLabel.text = [NSString stringWithFormat:localized, [heroInfo[@"result"] objectForKey:@"win_point"], [heroInfo[@"result"] objectForKey:@"rank"]];

        _challengebutton.hidden = YES;
        _resultButton.hidden = NO;
    } else {

        _resultLabel.text = nil;
        _challengebutton.hidden = NO;
        _resultButton.hidden = YES;
    }
}

@end

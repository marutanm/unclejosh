//
//  UJHomeProfileView.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHomeProfileView.h"
#import "DPMeterView.h"

@interface UJHomeProfileView ()

@property UILabel *nameLabel;
@property UIView  *nameBorder;
@property UILabel *lifeLabel;
@property UILabel *strengthLabel;
@property UILabel *agilityLabel;

@property DPMeterView *lifeGauge;
@property DPMeterView *strengthGauge;
@property DPMeterView *agilityGauge;

@property UIButton *challengebutton;
@property UIButton *resultButton;

@property UILabel *resultLabel;

@end

@implementation UJHomeProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZURUI_LIGHT_COLOR;

        NSInteger screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = ZURUI_LIGHT_COLOR;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:30];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.minimumScaleFactor = 0.6;
        _nameLabel.shadowColor = RGBACOLOR(255, 255, 255, 1);
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_nameLabel];

        _nameBorder = [[UIView alloc] init];
        _nameBorder.translatesAutoresizingMaskIntoConstraints = NO;
        _nameBorder.layer.borderColor = RGBACOLOR(0, 0, 0, 0.1).CGColor;
        _nameBorder.layer.borderWidth = 1;
        [self addSubview:_nameBorder];
        _nameBorder.hidden = YES;

        int padding = 10;
        NSInteger parameterWidth = screenWidth * 0.6 - padding*2;

        _lifeGauge = [[DPMeterView alloc] init];
        _lifeGauge.frame =  CGRectMake(padding, 50, parameterWidth, 20);
        _lifeGauge.meterType = DPMeterTypeLinearHorizontal;
        _lifeGauge.progressTintColor = LIFE_COLOR;
        [self addSubview:_lifeGauge];

        _lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 50, parameterWidth, 20)];
        _lifeLabel.backgroundColor = [UIColor clearColor];
        _lifeLabel.textColor = ZURUI_DARK_COLOR;
        [self addSubview:_lifeLabel];

        _strengthGauge = [[DPMeterView alloc] init];
        _strengthGauge.frame = CGRectMake(padding, 80, parameterWidth, 20);
        _strengthGauge.meterType = DPMeterTypeLinearHorizontal;
        _strengthGauge.progressTintColor = STRENGTH_COLOR;
        [self addSubview:_strengthGauge];

        _strengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 80, parameterWidth, 20)];
        _strengthLabel.backgroundColor = [UIColor clearColor];
        _strengthLabel.textColor = ZURUI_DARK_COLOR;
        [self addSubview:_strengthLabel];

        _agilityGauge = [[DPMeterView alloc] init];
        _agilityGauge.frame = CGRectMake(padding, 110, parameterWidth, 20);
        _agilityGauge.meterType = DPMeterTypeLinearHorizontal;
        _agilityGauge.progressTintColor = AGILIITY_COLOR;
        [self addSubview:_agilityGauge];

        _agilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 110, parameterWidth, 20)];
        _agilityLabel.backgroundColor = [UIColor clearColor];
        _agilityLabel.textColor = ZURUI_DARK_COLOR;
        [self addSubview:_agilityLabel];

        NSInteger rightOffset = screenWidth * 0.6;
        NSInteger controlWidth = screenWidth - rightOffset - padding;
        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
        [_challengebutton setTitle:NSLocalizedString(@"CHALLENGING", @"Labeo on challenge ranking button, state: disabled") forState:UIControlStateDisabled];
        _challengebutton.frame = CGRectMake(rightOffset, 50, controlWidth, 20);
        _challengebutton.hidden = YES;
        [_challengebutton addTarget:_delegate action:@selector(challengeRanking) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_challengebutton];

        _resultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resultButton setTitle:NSLocalizedString(@"RESULT", @"Label on show challenge result button") forState:UIControlStateNormal];
        _resultButton.frame = CGRectMake(rightOffset, 50, controlWidth, 20);
        _resultButton.hidden = YES;
        [_resultButton addTarget:_delegate action:@selector(showResults) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resultButton];

        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightOffset, 80, controlWidth, 20)];
        _resultLabel.backgroundColor = ZURUI_LIGHT_COLOR;
        [self addSubview:_resultLabel];

        [[DPMeterView appearance] setTrackTintColor:[UIColor lightGrayColor]];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];

    NSNumber *padding = @10;
    NSDictionary *paddingDictionary = NSDictionaryOfVariableBindings(padding);

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(padding)-[_nameLabel(==_nameBorder)]-(padding)-|"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_nameLabel, _nameBorder)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameBorder attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[_nameLabel][_nameBorder(==1)]"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_nameLabel, _nameBorder)]];
}

- (void)setHeroInfo:(NSDictionary *)heroInfo;
{
    _nameLabel.text = [heroInfo objectForKey:@"name"];
    _nameBorder.hidden = NO;
    _lifeLabel.text = [[heroInfo objectForKey:@"life"] stringValue];
    _strengthLabel.text = [[heroInfo objectForKey:@"strength"] stringValue];
    _agilityLabel.text = [[heroInfo objectForKey:@"agility"] stringValue];

    [_lifeGauge setProgress:[[heroInfo objectForKey:@"life"] floatValue] / 1000.0 animated:YES];
    [_strengthGauge setProgress:[[heroInfo objectForKey:@"strength"] floatValue] / 100.0 animated:YES];
    [_agilityGauge setProgress:[[heroInfo objectForKey:@"agility"] floatValue] / 100.0 animated:YES];

    [self setState:BEFORE_CHALLENGE];
    if (heroInfo[@"result"]) {
        [self setState:FINISHED];

        NSString *localized = NSLocalizedString(@"win:%@ ranking:%@", @"Result of challenge ranking");
        _resultLabel.text = [NSString stringWithFormat:localized, [heroInfo[@"result"] objectForKey:@"win_point"], [heroInfo[@"result"] objectForKey:@"rank"]];
    }
}

- (void)setState:(State)state;
{
    switch (state) {
        case BEFORE_CHALLENGE:
            _resultLabel.text = nil;
            _challengebutton.hidden = NO;
            _challengebutton.enabled = YES;
            _resultButton.hidden = YES;
            break;

        case CHALLENGING:
            _challengebutton.enabled = NO;
            break;

        case FINISHED:
            _challengebutton.enabled = YES;
            _resultButton.hidden = NO;
            break;

        default:
            break;
    }
}

@end

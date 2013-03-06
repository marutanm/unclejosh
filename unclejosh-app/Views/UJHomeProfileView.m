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

        _lifeGauge = [[DPMeterView alloc] init];
        _lifeGauge.meterType = DPMeterTypeLinearHorizontal;
        _lifeGauge.progressTintColor = LIFE_COLOR;
        _lifeGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_lifeGauge];

        _lifeLabel = [[UILabel alloc] init];
        _lifeLabel.backgroundColor = [UIColor clearColor];
        _lifeLabel.textColor = ZURUI_DARK_COLOR;
        _lifeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_lifeLabel];

        _strengthGauge = [[DPMeterView alloc] init];
        _strengthGauge.meterType = DPMeterTypeLinearHorizontal;
        _strengthGauge.progressTintColor = STRENGTH_COLOR;
        _strengthGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_strengthGauge];

        _strengthLabel = [[UILabel alloc] init];
        _strengthLabel.backgroundColor = [UIColor clearColor];
        _strengthLabel.textColor = ZURUI_DARK_COLOR;
        _strengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_strengthLabel];

        _agilityGauge = [[DPMeterView alloc] init];
        _agilityGauge.meterType = DPMeterTypeLinearHorizontal;
        _agilityGauge.progressTintColor = AGILIITY_COLOR;
        _agilityGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_agilityGauge];

        _agilityLabel = [[UILabel alloc] init];
        _agilityLabel.backgroundColor = [UIColor clearColor];
        _agilityLabel.textColor = ZURUI_DARK_COLOR;
        _agilityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_agilityLabel];

        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
        [_challengebutton setTitle:NSLocalizedString(@"CHALLENGING", @"Labeo on challenge ranking button, state: disabled") forState:UIControlStateDisabled];
        _challengebutton.hidden = YES;
        _challengebutton.translatesAutoresizingMaskIntoConstraints = NO;
        [_challengebutton addTarget:_delegate action:@selector(challengeRanking) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_challengebutton];

        _resultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_resultButton setTitle:NSLocalizedString(@"RESULT", @"Label on show challenge result button") forState:UIControlStateNormal];
        _resultButton.hidden = YES;
        _resultButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_resultButton addTarget:_delegate action:@selector(showResults) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resultButton];

        _resultLabel = [[UILabel alloc] init];
        _resultLabel.backgroundColor = ZURUI_LIGHT_COLOR;
        _resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_resultLabel];

        [[DPMeterView appearance] setTrackTintColor:[UIColor lightGrayColor]];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];

    NSNumber *padding = @10;
    NSNumber *gaugeWidth = @([[UIScreen mainScreen] applicationFrame].size.width * 0.6 - 10 * 2);
    NSDictionary *paddingDictionary = NSDictionaryOfVariableBindings(padding, gaugeWidth);

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(padding)-[_nameLabel(==_nameBorder)]-(padding)-|"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_nameLabel, _nameBorder)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameBorder attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(padding)-[_lifeGauge(==_strengthGauge,==_agilityGauge,==gaugeWidth)]-[_challengebutton(==_resultButton,==_resultLabel)]-|"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_lifeGauge, _strengthGauge, _agilityGauge, _challengebutton, _resultButton, _resultLabel)]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strengthGauge attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_lifeGauge attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_agilityGauge attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_lifeGauge attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lifeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_lifeGauge attribute:NSLayoutAttributeLeft multiplier:1.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lifeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_lifeGauge attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strengthLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_strengthGauge attribute:NSLayoutAttributeLeft multiplier:1.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strengthLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_strengthGauge attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_agilityLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_agilityGauge attribute:NSLayoutAttributeLeft multiplier:1.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_agilityLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_agilityGauge attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_resultButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_challengebutton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_resultLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_challengebutton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];


    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[_nameLabel][_nameBorder(==1)]-(padding)-[_lifeGauge(==20)]-(padding)-[_strengthGauge(==20)]-(padding)-[_agilityGauge(==20)]-(padding)-|"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_nameLabel, _nameBorder, _lifeGauge, _strengthGauge, _agilityGauge)]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameBorder(==1)]-[_challengebutton(==_resultButton)]-[_resultLabel]-(padding)-|"
                                                                 options:0
                                                                 metrics:paddingDictionary
                                                                   views:NSDictionaryOfVariableBindings(_nameBorder, _challengebutton, _resultButton, _resultLabel)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_resultButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_challengebutton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
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

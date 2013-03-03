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

        NSInteger padding = 10;
        NSInteger screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;

        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, screenWidth - padding*2, 30)];
        _nameLabel.backgroundColor = ZURUI_LIGHT_COLOR;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont boldSystemFontOfSize:30];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.minimumScaleFactor = 0.6;
        _nameLabel.shadowColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_nameLabel];

        NSInteger parameterWidth = screenWidth * 0.6 - padding*2;

        _lifeGauge = [[DPMeterView alloc] init];
        _lifeGauge.frame =  CGRectMake(padding, 50, parameterWidth, 20);
        _lifeGauge.meterType = DPMeterTypeLinearHorizontal;
        _lifeGauge.progressTintColor = LIFE_COLOR;
        [self addSubview:_lifeGauge];

        _lifeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 50, parameterWidth, 20)];
        _lifeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_lifeLabel];

        _strengthGauge = [[DPMeterView alloc] init];
        _strengthGauge.frame = CGRectMake(padding, 80, parameterWidth, 20);
        _strengthGauge.meterType = DPMeterTypeLinearHorizontal;
        _strengthGauge.progressTintColor = STRENGTH_COLOR;
        [self addSubview:_strengthGauge];

        _strengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 80, parameterWidth, 20)];
        _strengthLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_strengthLabel];

        _agilityGauge = [[DPMeterView alloc] init];
        _agilityGauge.frame = CGRectMake(padding, 110, parameterWidth, 20);
        _agilityGauge.meterType = DPMeterTypeLinearHorizontal;
        [self addSubview:_agilityGauge];

        _agilityLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding * 1.5, 110, parameterWidth, 20)];
        _agilityLabel.backgroundColor = [UIColor clearColor];
        _agilityGauge.progressTintColor = AGILIITY_COLOR;
        [self addSubview:_agilityLabel];

        NSInteger rightOffset = screenWidth * 0.6;
        NSInteger controlWidth = screenWidth - rightOffset - padding;
        _challengebutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_challengebutton setTitle:NSLocalizedString(@"FIGHT", @"Label on challenge ranking button") forState:UIControlStateNormal];
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

- (void)setHeroInfo:(NSDictionary *)heroInfo;
{
    _nameLabel.text = [heroInfo objectForKey:@"name"];
    _lifeLabel.text = [[heroInfo objectForKey:@"life"] stringValue];
    _strengthLabel.text = [[heroInfo objectForKey:@"strength"] stringValue];
    _agilityLabel.text = [[heroInfo objectForKey:@"agility"] stringValue];

    [_lifeGauge setProgress:[[heroInfo objectForKey:@"life"] floatValue] / 1000.0 animated:YES];
    [_strengthGauge setProgress:[[heroInfo objectForKey:@"strength"] floatValue] / 100.0 animated:YES];
    [_agilityGauge setProgress:[[heroInfo objectForKey:@"agility"] floatValue] / 100.0 animated:YES];

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

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);

    CGContextSetStrokeColorWithColor(context, RGBACOLOR(0, 0, 0, 0.1).CGColor);
    CGContextMoveToPoint(context, 10, 40);
    CGContextAddLineToPoint(context, 310, 40);
    CGContextStrokePath(context);

    CGContextSetStrokeColorWithColor(context, RGBACOLOR(255, 255, 255, 0.1).CGColor);
    CGContextMoveToPoint(context, 10, 42);
    CGContextAddLineToPoint(context, 310, 42);
    CGContextStrokePath(context);
}

@end

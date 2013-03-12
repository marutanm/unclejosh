//
//  UJBattleResultTableHeader.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 3/11/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJBattleResultTableHeader.h"
#import "DPMeterView.h"

@interface UJBattleResultTableHeader ()

@property DPMeterView *leftGauge;
@property DPMeterView *rightGauge;

@end

@implementation UJBattleResultTableHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = ZURUI_LIGHT_COLOR;

        _leftGauge = [[DPMeterView alloc] init];
        _leftGauge.meterType = DPMeterTypeLinearHorizontal;
        _leftGauge.progressTintColor = LIFE_COLOR;
        _leftGauge.trackTintColor = [UIColor redColor];
        _leftGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_leftGauge];

        _rightGauge = [[DPMeterView alloc] init];
        _rightGauge.gradientOrientationAngle = M_PI;
        _rightGauge.progressTintColor = LIFE_COLOR;
        _rightGauge.trackTintColor = [UIColor redColor];
        _rightGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_rightGauge];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_leftGauge]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_leftGauge)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_rightGauge]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_rightGauge)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftGauge(==_rightGauge)]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_leftGauge, _rightGauge)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightGauge attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_leftGauge attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    }
    return self;
}

-(void)setLifes:(NSDictionary *)lifes
{
    [_leftGauge setProgress:[lifes[@"challenger"][@"current"] floatValue] / [lifes[@"challenger"][@"last"] floatValue]];
    [_rightGauge setProgress:[lifes[@"master"][@"current"] floatValue] / [lifes[@"master"][@"last"] floatValue]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_leftGauge attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(0.5 * [lifes[@"challenger"][@"last"] floatValue] / 1000.0) constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightGauge attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:(0.5 * [lifes[@"master"][@"last"] floatValue] / 1000.0) constant:0]];
}

@end

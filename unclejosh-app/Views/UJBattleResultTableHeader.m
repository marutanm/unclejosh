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

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_leftGauge(==_rightGauge)][_rightGauge]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_leftGauge, _rightGauge)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftGauge(==_rightGauge)]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_leftGauge, _rightGauge)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightGauge attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_leftGauge attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    }
    return self;
}

- (void)setLifesLeft:(NSInteger)left right:(NSInteger)right;
{
    NIDPRINT(@"%d:%d", left, right);
    [_leftGauge setProgress:left / 1000.0];
    [_rightGauge setProgress:right/ 1000.0];
}

@end

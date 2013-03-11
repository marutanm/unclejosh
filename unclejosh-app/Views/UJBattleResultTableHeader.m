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
        _leftGauge = [[DPMeterView alloc] init];
        _leftGauge.meterType = DPMeterTypeLinearHorizontal;
        _leftGauge.progressTintColor = [UIColor redColor];
        _leftGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_leftGauge];

        _rightGauge = [[DPMeterView alloc] init];
        _rightGauge.meterType = DPMeterTypeLinearHorizontal;
        _rightGauge.progressTintColor = [UIColor redColor];
        _rightGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_rightGauge];

    }
    return self;
}

- (void)setLifesLeft:(NSInteger)left right:(NSInteger)right;
{
    NIDPRINT(@"%d:%d", left, right);
}

@end

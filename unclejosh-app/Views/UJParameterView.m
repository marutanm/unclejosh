//
//  UJParameterView.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/27/13.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJParameterView.h"

@implementation UJParameterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _max = 100;
        _value = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextStrokeRectWithWidth(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * _value / _max, rect.size.height), 0);
    CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * _value / _max, rect.size.height));

    CGContextStrokePath(context);
}

- (void)setValue:(NSInteger)value
{
    _value = value;
    [self setNeedsDisplay];
}

@end

//
//  UJHeroTableViewCell.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 3/2/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHeroTableViewCell.h"
#import "DPMeterView.h"

@interface UJHeroTableViewCell ()

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIView *lifeGauge;
@property (nonatomic) UIView *strengthGauge;
@property (nonatomic) UIView *agilityGauge;

@property (nonatomic) UILabel *rankLabel;

@end

@implementation UJHeroTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.shadowColor = ZURUI_LIGHT_COLOR;
        [self.contentView addSubview:_nameLabel];

        _lifeGauge = [[UIView alloc] init];
        _lifeGauge.backgroundColor = LIFE_COLOR;
        _lifeGauge.alpha = 0.2;
        _lifeGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_lifeGauge];

        _strengthGauge = [[UIView alloc] init];
        _strengthGauge.backgroundColor = STRENGTH_COLOR;
        _strengthGauge.alpha = 0.2;
        _strengthGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_strengthGauge];

        _agilityGauge = [[UIView alloc] init];
        _agilityGauge.backgroundColor = AGILIITY_COLOR;
        _agilityGauge.alpha = 0.2;
        _agilityGauge.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_agilityGauge];

        _rankLabel = [[UILabel alloc] init];
        _rankLabel.backgroundColor = [UIColor clearColor];
        _rankLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _rankLabel.shadowColor = ZURUI_LIGHT_COLOR;
        _rankLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_rankLabel];

        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_rankLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rankLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rankLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rankLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_lifeGauge][_strengthGauge][_agilityGauge]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lifeGauge, _strengthGauge, _agilityGauge)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lifeGauge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lifeGauge)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_strengthGauge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_strengthGauge)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_agilityGauge]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_agilityGauge)]];
        [self.contentView addConstraints:constraints];

        [self.contentView bringSubviewToFront:_nameLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    _lifeGauge.backgroundColor = LIFE_COLOR;
    _strengthGauge.backgroundColor = STRENGTH_COLOR;
    _agilityGauge.backgroundColor = AGILIITY_COLOR;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];

    _lifeGauge.backgroundColor = LIFE_COLOR;
    _strengthGauge.backgroundColor = STRENGTH_COLOR;
    _agilityGauge.backgroundColor = AGILIITY_COLOR;
}

- (void)setHero:(NSDictionary *)hero
{
    NIDPRINT(@"%@", hero);
    _hero = hero;
    _nameLabel.text = [hero objectForKey:@"name"];

    NSDictionary *defaultWidth = @{@"life":     @(self.contentView.frame.size.width * 0.5),
                                   @"strength": @(self.contentView.frame.size.width * 0.25),
                                   @"agility":  @(self.contentView.frame.size.width * 0.25)};
    NSNumber *lifeGaugeWidth = @([defaultWidth[@"life"] intValue] * [[hero objectForKey:@"life"] floatValue] / 1000);
    NSNumber *strengthGaugeWidth = @([defaultWidth[@"strength"] intValue] * [[hero objectForKey:@"strength"] floatValue] / 100);
    NSNumber *agilityGaugeWidth = @([defaultWidth[@"agility"] intValue] * [[hero objectForKey:@"agility"] floatValue] / 100);
    [_lifeGauge removeConstraints:_lifeGauge.constraints];
    [_strengthGauge removeConstraints:_strengthGauge.constraints];
    [_agilityGauge removeConstraints:_agilityGauge.constraints];
    [_lifeGauge addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_lifeGauge(lifeGaugeWidth)]" options:0 metrics:NSDictionaryOfVariableBindings(lifeGaugeWidth) views:NSDictionaryOfVariableBindings(_lifeGauge)]];
    [_strengthGauge addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_strengthGauge(strengthGaugeWidth)]" options:0 metrics:NSDictionaryOfVariableBindings(strengthGaugeWidth) views:NSDictionaryOfVariableBindings(_strengthGauge)]];
    [_agilityGauge addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_agilityGauge(agilityGaugeWidth)]" options:0 metrics:NSDictionaryOfVariableBindings(agilityGaugeWidth) views:NSDictionaryOfVariableBindings(_agilityGauge)]];

    _rankLabel.text = nil;
    if ([hero objectForKey:@"result"]) {
        _rankLabel.text = [NSString stringWithFormat:@"%@", [[hero objectForKey:@"result"] objectForKey:@"rank"]];
    }
}

@end

//
//  UJHeroTableViewCell.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 3/2/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJHeroTableViewCell.h"

@implementation UJHeroTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHero:(NSDictionary *)hero
{
    _hero = hero;
    self.textLabel.text = [hero objectForKey:@"name"];
}

@end

//
//  UJResultTableViewCell.m
//  unclejosh-app
//
//  Created by Ryo Fujita on 3/5/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import "UJResultTableViewCell.h"

@interface UJResultTableViewCell ()

@property (nonatomic) UILabel *resultLabel;
@property (nonatomic) UILabel *nameLabel;

@end

@implementation UJResultTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.backgroundColor = [UIColor clearColor];
        _resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.font = [UIFont boldSystemFontOfSize:18];
        _resultLabel.textColor = ZURUI_LIGHT_COLOR;
        _resultLabel.shadowColor = ZURUI_DARK_COLOR;
        _resultLabel.shadowOffset = CGSizeMake(0, -0.4);
        _resultLabel.layer.shadowOpacity = 1;
        _resultLabel.layer.shadowOffset = CGSizeMake(0,0);
        _resultLabel.layer.shadowRadius = 2;
        [self.contentView addSubview:_resultLabel];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.shadowColor = ZURUI_LIGHT_COLOR;
        [self.contentView addSubview:_nameLabel];

        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-4-[_resultLabel(==50)]-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_resultLabel, _nameLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[_resultLabel]-4-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_resultLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
        [self.contentView addConstraints:constraints];

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setResult:(NSDictionary *)result
{
    NIDPRINT(@"%@", result);

    if (![result objectForKey:@"winner_id"]) {
        _resultLabel.text = NSLocalizedString(@"DRAW", @"label of result table: draw");
        _resultLabel.layer.shadowColor = [UIColor greenColor].CGColor;

    } else if ([[result objectForKey:@"winner_id"] isEqualToString:[[result objectForKey:@"master"] objectForKey:@"id"]]) {
        _resultLabel.text = NSLocalizedString(@"LOSE", @"label of result table: lose");
        _resultLabel.layer.shadowColor = [UIColor blueColor].CGColor;

    } else {
        _resultLabel.text = NSLocalizedString(@"WIN", @"label of result table: win");
        _resultLabel.layer.shadowColor = [UIColor redColor].CGColor;
    }

    _nameLabel.text = [[result objectForKey:@"master"] objectForKey:@"name"];
}

@end

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
        _resultLabel.shadowColor = ZURUI_LIGHT_COLOR;
        [self.contentView addSubview:_resultLabel];

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.shadowColor = ZURUI_LIGHT_COLOR;
        [self.contentView addSubview:_nameLabel];

        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_resultLabel]-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_resultLabel, _nameLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_resultLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_resultLabel)]];
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

    if ([[result objectForKey:@"win"] boolValue]) {
        _resultLabel.text = NSLocalizedString(@"WIN", @"label of result table: win");
        _resultLabel.textColor = [UIColor redColor];
    } else {
        _resultLabel.text = NSLocalizedString(@"LOSE", @"label of result table: lose");
        _resultLabel.textColor = [UIColor blueColor];
    }

    _nameLabel.text = [[result objectForKey:@"master"] objectForKey:@"name"];
}

@end

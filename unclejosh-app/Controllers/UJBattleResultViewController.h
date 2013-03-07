//
//  UJBattleResultViewController.h
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/26/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UJBattleResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString* battleId;

@end

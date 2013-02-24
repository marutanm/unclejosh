//
//  UJHomeProfileView.h
//  unclejosh-app
//
//  Created by Ryo Fujita on 2/20/2013.
//  Copyright (c) 2013 Ryo Fujita. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UJHomeProfileViewDelegate <NSObject>

- (void)challengeRanking;
- (void)showResults;

@end

@interface UJHomeProfileView : UIView

@property (nonatomic) id <UJHomeProfileViewDelegate> delegate;

- (void)setHeroInfo:(NSDictionary *)heroInfo;

@end

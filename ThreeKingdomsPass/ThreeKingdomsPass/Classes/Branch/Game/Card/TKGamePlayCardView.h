//
//  TKGamePlayCardView.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/10.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKGamePlayCardViewDelegate;

@interface TKGamePlayCardView : UIView

@property (nonatomic, weak) id<TKGamePlayCardViewDelegate> delegate;

@end

@protocol TKGamePlayCardViewDelegate <NSObject>

@optional
- (void)userGetCard;

@end

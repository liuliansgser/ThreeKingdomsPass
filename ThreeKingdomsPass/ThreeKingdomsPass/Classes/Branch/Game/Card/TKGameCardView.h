//
//  TKGameCardView.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGameCardData.h"

@protocol TKGameCardViewDelegate;

@interface TKGameCardView : UIImageView

@property (nonatomic, weak) id<TKGameCardViewDelegate> delegate;
@property (nonatomic, unsafe_unretained) CGRect crashTestRect;

- (id)initWithFrame:(CGRect)frame WithCardData:(TKGameCardData *)data;

@end

@protocol TKGameCardViewDelegate <NSObject>

@optional
- (void)dragCardViewChange:(TKGameCardView *)view;
- (void)dragCardViewEnd:(TKGameCardView *)view;

@end

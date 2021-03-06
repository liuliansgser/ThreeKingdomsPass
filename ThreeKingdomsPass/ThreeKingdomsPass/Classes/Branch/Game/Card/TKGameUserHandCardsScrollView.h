//
//  TKGameUserHandCardsScrollView.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKGameCardData.h"
#import "TKRoleData+Event.h"

@interface TKGameUserHandCardsScrollView : UIScrollView

@property (nonatomic, unsafe_unretained) BOOL isDropStatus;

- (void)setUpRole:(TKRoleData *)role;
- (void)updateItemsWithCards;
- (void)addSingleCardData:(TKGameCardData *)data;

@end

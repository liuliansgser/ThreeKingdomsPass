//
//  TKRoleData+Event.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKRoleData.h"
#import "TKGameCardData.h"

@interface TKRoleData (Event)

//从牌堆顶摸牌
- (void)getCardFromPlayCardsWithCount:(NSUInteger)count;
//弃牌
- (void)dropCard:(TKGameCardData *)card;
//弃牌（从手牌）
- (void)dropCardFromHandCards:(TKGameCardData *)card;

@end

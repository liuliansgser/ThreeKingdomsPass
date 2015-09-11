//
//  TKRoleData+Event.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/11.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKRoleData+Event.h"
#import "TKGame.h"

@implementation TKRoleData (Event)

- (void)getCardFromPlayCardsWithCount:(NSUInteger)count
{
    //判断剩余牌堆是否够用
    [TK_GAME supplementWithCount:count];
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < count; i++) {
        [self.handcards addObject:TK_GAME.playCards[i]];
        NSLog(@"[%@]从牌堆顶抓牌:",self.name);
        [TK_GAME.playCards[i] showCardInfomation];
        [indexSet addIndex:i];
    }
    [TK_GAME.playCards removeObjectsAtIndexes:indexSet];
}

- (void)dropCard:(TKGameCardData *)card
{
    if ([card isKindOfClass:[TKGameCardData class]]) {
        [TK_GAME.dropCards addObject:card];
    }
    
    NSLog(@"弃牌堆张数:[%lu]",(unsigned long)[TK_GAME.dropCards count]);
}

- (void)dropCardFromHandCards:(TKGameCardData *)card
{
    if ([card isKindOfClass:[TKGameCardData class]]) {
        [self.handcards removeObject:card];
        [self dropCard:card];
    }
}

@end

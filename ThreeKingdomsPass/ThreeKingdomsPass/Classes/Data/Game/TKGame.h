//
//  TKGame.h
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKGloble.h"

@interface TKGame : NSObject

@property (nonatomic, strong) NSArray *normalcards;

//牌堆(使用中)
@property (nonatomic, strong) NSMutableArray *playCards;
//牌堆(弃掉)
@property (nonatomic, strong) NSMutableArray *dropCards;

TK_SINGLETION_h(TKGloble)

- (NSArray *)shuffleTheCardsWithCardsArray:(NSArray *)cards;
- (void)supplementWithCount:(NSInteger)count;

@end

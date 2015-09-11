//
//  TKGame.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGame.h"

@implementation TKGame

TK_SINGLETION_m(TKGame)

- (id)init {
    if (self = [super init]) {
        _playCards = [NSMutableArray array];
        _dropCards = [NSMutableArray array];
    }
    return self;
}



- (NSArray *)shuffleTheCardsWithCardsArray:(NSArray *)cards
{
    if ([cards count] == 0) NSAssert(false, @"需要洗混的牌堆不能为空");
    
    NSInteger index = 0;
    NSInteger length = [cards count];
    NSDictionary *temp = nil;
    NSInteger value = 0;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:cards];
    
    for(index = 0; index < length; index++){
        value = index + arc4random() % (length - index);
        temp = tempArray[index];
        tempArray[index] = tempArray[value];
        tempArray[value] = temp;
    }
    
    return tempArray;
}

- (void)supplementWithCount:(NSInteger)count
{
    //如果需要新牌堆
    if ([_playCards count] < count) {
        //洗混弃牌堆
        NSArray *newCards = [self shuffleTheCardsWithCardsArray:_dropCards];
        [_playCards addObjectsFromArray:newCards];
        [_dropCards removeAllObjects];
    }
}

@end

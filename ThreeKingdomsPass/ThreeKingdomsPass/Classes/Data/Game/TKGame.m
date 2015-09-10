//
//  TKGame.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGame.h"
#import "TKGameCardData.h"

@implementation TKGame

TK_SINGLETION_m(TKGloble)

- (id)init {
    if (self = [super init]) {
        self.normalcards = [self _normalcards];
    }
    return self;
}

- (NSArray *)_normalcards
{
    if (!self.normalcards) {
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"card"
                                                       ofType:@"pass"]
                                              options:NSDataReadingUncached
                                                error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        NSArray *normal = [dictionary objectForKey:@"normal"];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[normal count]];
        for (NSUInteger i = 0; i < [normal count]; i++) {
            TKGameCardData *cardData = [[TKGameCardData alloc] initWithCardData:normal[i]];
            if (cardData.name != nil) [array addObject:cardData];
        }
        return array;
    }
    return self.normalcards;
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

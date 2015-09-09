//
//  TKGameUserHandCardsScrollView.m
//  ThreeKingdomsPass
//
//  Created by 刘潋 on 15/9/9.
//  Copyright (c) 2015年 刘潋. All rights reserved.
//

#import "TKGameUserHandCardsScrollView.h"
#import "TKGloble.h"
#import "TKGameCardView.h"
#import "NSArray+BlocksKit.h"

@interface TKGameUserHandCardsScrollView ()

@property (nonatomic, strong) NSMutableArray *sortingCards;
@property (nonatomic, strong) NSArray *cards;
@property (nonatomic, strong) NSString *beforeName;
@property (nonatomic, unsafe_unretained) NSUInteger tightenCount;
@property (nonatomic, unsafe_unretained) NSUInteger lastTag;

@end

@implementation TKGameUserHandCardsScrollView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.sortingCards = [NSMutableArray array];
    }
    return self;
}

- (void)updateItemsWithCards:(NSArray *)cards
{
    self.cards = [cards mutableCopy];
    
    for (TKGameCardView *cardView in self.subviews) {
        if ([cardView isKindOfClass:[TKGameCardView class]]) {
            [cardView removeFromSuperview];
        }
    }
    
    __weak TKGameUserHandCardsScrollView *me = self;
    
    [self.cards enumerateObjectsUsingBlock:^(TKGameCardData *data, NSUInteger idx, BOOL *stop) {
        NSLog(@"[%@]:[%@]",me.beforeName,data.name);
        BOOL isSameName = [me.beforeName isEqualToString:data.name]?YES:NO;
        TKGameCardView *cardView = [[TKGameCardView alloc] initWithFrame:CGRectMake(idx*(TK_CARD_USERHAND_WIDTH+1.f)-(isSameName?(TK_CARD_USERHAND_WIDTH-10.f):0.f)-(me.tightenCount*(TK_CARD_USERHAND_WIDTH-10.f)), 0, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT) WithCardData:data];
        [self addSubview:cardView];
        if (isSameName) me.tightenCount++;
        me.beforeName = data.name;
        cardView.tag = idx;
        me.lastTag = idx;
    }];
    
    TKGameCardView *lastView = (TKGameCardView *)[self viewWithTag:self.lastTag];
    self.contentSize = CGSizeMake(lastView.frame.origin.x+TK_CARD_USERHAND_WIDTH, 0);
}

- (void)sorting
{
    [self.sortingCards removeAllObjects];
    self.beforeName = nil;
    self.tightenCount = 0;
    self.lastTag = 0;
    
    [self _soringWithName:@"杀"];
    [self _soringWithName:@"闪"];
    [self _soringWithName:@"桃"];
    [self _soringWithType:CardTypeTrick];
    [self _soringWithType:CardTypeWeapon];
    [self _soringWithType:CardTypeArmor];
    [self _soringWithType:CardTypeDHorse];
    [self _soringWithType:CardTypeAHorse];
    
    [self updateItemsWithCards:self.sortingCards];
}

- (void)_soringWithName:(NSString *)name
{
    NSArray *array = [self.cards bk_select:^BOOL(TKGameCardData *data) {
        return [data.name isEqualToString:name];
    }];
    
    if ([array count] > 0) {
        [self.sortingCards addObjectsFromArray:array];
    }
}

- (void)_soringWithType:(CardType)type
{
    NSArray *array = [self.cards bk_select:^BOOL(TKGameCardData *data) {
        return data.type == type;
    }];
    
    if ([array count] > 0) {
        [self.sortingCards addObjectsFromArray:array];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

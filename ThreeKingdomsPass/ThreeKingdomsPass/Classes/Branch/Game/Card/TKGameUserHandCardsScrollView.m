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

@implementation TKGameUserHandCardsScrollView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)updateItemsWithCards:(NSArray *)cards
{
    [cards enumerateObjectsUsingBlock:^(TKGameCardData *data, NSUInteger idx, BOOL *stop) {
        TKGameCardView *cardView = [[TKGameCardView alloc] initWithFrame:CGRectMake(idx*(TK_CARD_USERHAND_WIDTH+1.f), 0, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT) WithCardData:data];
        [self addSubview:cardView];
    }];
    
    self.contentSize = CGSizeMake([cards count]*(TK_CARD_USERHAND_WIDTH+1.f), 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

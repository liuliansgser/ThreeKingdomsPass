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

@interface TKGameUserHandCardsScrollView () <TKGameCardViewDelegate>

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation TKGameUserHandCardsScrollView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.clipsToBounds = NO;
        self.views = [NSMutableArray array];
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
    
    [self.cards enumerateObjectsUsingBlock:^(TKGameCardData *data, NSUInteger idx, BOOL *stop) {
        TKGameCardView *cardView = [[TKGameCardView alloc] initWithFrame:CGRectMake(1.f+idx*(TK_CARD_USERHAND_WIDTH+1.f), -1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT) WithCardData:data];
        cardView.delegate = self;
        cardView.tag = idx+100;
        [self addSubview:cardView];
        [self.views addObject:cardView];
        
    }];
    self.contentSize = CGSizeMake(1.f+[self.cards count]*(TK_CARD_USERHAND_WIDTH+1.f), 0);
}

- (void)tapCardView:(TKGameCardView *)view
{
    NSArray *tap = [self.views bk_select:^BOOL(TKGameCardView *view) {
        return view.isTap;
    }];
    NSInteger n = [tap count];
    for(NSInteger i = 0; i < n; i++){
        TKGameCardView *cardView = (TKGameCardView *)tap[i];
        [UIView animateWithDuration:0.25 delay:0.03*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            cardView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            cardView.isTap = NO;
        }];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        view.transform = view.isTap?CGAffineTransformIdentity:CGAffineTransformMakeTranslation(0, -10);
        view.isTap = !view.isTap;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dragCardViewChange:(TKGameCardView *)view
{
    NSInteger insertIndex = view.tag;
    NSInteger isDrag = 0;
    [self _calculateDragArea:&isDrag andInsertIndex:&insertIndex forCardView:view];
    [self _adjustAreaItem:view insertIndex:insertIndex];
}

- (void)_calculateDragArea:(NSInteger *)areaNum andInsertIndex:(NSInteger *)insertIndex forCardView:(TKGameCardView *)view
{
    *insertIndex = [self _confirmTheInsertIndexWithArray:[self.views copy] forCardView:view];
    *areaNum = -1;
}

- (NSInteger)_confirmTheInsertIndexWithArray:(NSArray *)array forCardView:(TKGameCardView *)view
{
    NSInteger insertIndex = array.count;
    for (NSInteger i = 0;i < array.count; i++) {
        TKGameCardView *card = (TKGameCardView *)array[i];
        if (CGRectIntersectsRect(view.frame, card.crashTestRect)) {
            insertIndex = i;
            break;
        }
    }
    
    return insertIndex;
}

- (void)_adjustAreaItem:(TKGameCardView *)view insertIndex:(NSInteger)insertIndex
{
    if (view.tag == insertIndex) {
        return;
    }
    
    NSMutableArray *views = self.views;
    NSMutableArray *cards = self.cards;
    
    NSObject *objTemp = [self.cards objectAtIndex:(view.tag-100)];
    [views removeObjectAtIndex:(view.tag-100)];
    [cards removeObjectAtIndex:(view.tag-100)];
    if (insertIndex >= views.count) {
        [views addObject:view];
        [cards addObject:objTemp];
    }else{
        [views insertObject:view atIndex:insertIndex];
        [cards insertObject:objTemp atIndex:insertIndex];
    }
    
    NSInteger exceptionIndex = [views indexOfObject:view];
    [views enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(TKGameCardView *)obj setTag:-1];
    }];
    view.tag = exceptionIndex;
    [self _layoutExceptIndex:exceptionIndex];
}

- (void)_layoutExceptIndex:(NSInteger)exceptIndex
{
    NSInteger n = [self.cards count];
    for(NSInteger i = 0; i < n; i++){
        TKGameCardView *cardView = (TKGameCardView *)self.views[i];
        cardView.tag = i+100;
        cardView.transform = CGAffineTransformIdentity;
        cardView.isTap = NO;
        CGRect rect = CGRectMake(1.f+i*(TK_CARD_USERHAND_WIDTH+1.f), -1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    
        if (exceptIndex == i) {
            //重置碰撞区域
            cardView.crashTestRect = CGRectInset(rect, 20.f, 10.f);
            continue;
        }
        [UIView animateWithDuration:0.25 delay:0.03*i options:UIViewAnimationOptionCurveEaseOut animations:^{
            cardView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dragCardViewEnd:(TKGameCardView *)view
{
    NSUInteger index = view.tag;
    CGRect rect = CGRectMake(1.f+(index-100)*(TK_CARD_USERHAND_WIDTH+1.f), -1.f, TK_CARD_USERHAND_WIDTH, TK_CARD_USERHAND_HEIGHT);
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
